Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6B590EACC
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jun 2024 14:20:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJuHr-000478-Rt; Wed, 19 Jun 2024 08:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJuHp-00041B-BE
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJuHn-00030l-3h
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718799574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xRjSDQPUN9yR181H1pYhhqPDUx70bqYDH7/xlAuPg/Q=;
 b=dlrM2R+KO2wBWkd8CU31AlknTcXPUcxYWsZ3gL1KZkhgNEAfm1mVNHRLKgYJNR+Y8D1w8l
 CBHNW95s/equj9JrHQDTZcGB5ImZHrdHHWErUjYayj4MlCwpfuuCZxW8+09vtZMxXTngtI
 YL0gkSYOeeiEqYy2HHppKv8dyfIdL+U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-19u0TlfENJ2yHA01L6QVXw-1; Wed,
 19 Jun 2024 08:19:29 -0400
X-MC-Unique: 19u0TlfENJ2yHA01L6QVXw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E28119560B4; Wed, 19 Jun 2024 12:19:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83B013000218; Wed, 19 Jun 2024 12:19:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD34721E6621; Wed, 19 Jun 2024 14:19:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Victor Toso de
 Carvalho <victortoso@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Fabiano Rosas <farosas@suse.de>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Peter Xu <peterx@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,  Jiri Pirko <jiri@resnulli.us>,  Alex Williamson
 <alex.williamson@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 11/13] qapi: add markup to note blocks
In-Reply-To: <20240619003012.1753577-12-jsnow@redhat.com> (John Snow's message
 of "Tue, 18 Jun 2024 20:30:10 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-12-jsnow@redhat.com>
Date: Wed, 19 Jun 2024 14:19:20 +0200
Message-ID: <87h6dp15x3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

John Snow <jsnow@redhat.com> writes:

> Generally, surround command-line options with ``literal`` markup to help
> it stand out from prose in rendered HTML, and add cross-references to
> replace "see also" messages.
>
> References to types, values, and other QAPI definitions are not yet
> adjusted here; they will be converted en masse in a subsequent patch
> after the new QAPI doc generator is merged.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>



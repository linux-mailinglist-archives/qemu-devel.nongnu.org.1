Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9223E91A455
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jun 2024 12:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMmiZ-0004Z7-0x; Thu, 27 Jun 2024 06:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sMmiW-0004Yq-NV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sMmiS-0006B8-0x
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719485459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=sD4v3Z5OJ0gM0AlBQaLc16t1VQbDPhBLxpZmUeyZ+yY=;
 b=NCe7yQAms9Js659KfkmegyLv2cWSh13ePhxidayilffCwX5q0dN2x48pmtI2B0tbWmp4Rz
 dhrdcvn0Z3WUpOCOYNSFScpsCfo5cK6o25UEzz/FWL++q06xoeGiVRzANtnbjnbNOhCXHf
 rN5L1X8mddIv63WT+K5HEN/TPxpoRwQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-SLHGmjIhMpq4b1Jp4Ahlcw-1; Thu,
 27 Jun 2024 06:50:55 -0400
X-MC-Unique: SLHGmjIhMpq4b1Jp4Ahlcw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24B4719560B5; Thu, 27 Jun 2024 10:50:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FB433000601; Thu, 27 Jun 2024 10:50:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DD7F21E668B; Thu, 27 Jun 2024 12:50:50 +0200 (CEST)
Resent-To: michael.roth@amd.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, wangyanan55@huawei.com, pavel.dovgaluk@ispras.ru,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, jiri@resnulli.us, farosas@suse.de,
 lukasstraub2@web.de, mads@ynddal.dk
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 27 Jun 2024 12:50:50 +0200
Resent-Message-ID: <87ikxu8xrp.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Mads Ynddal <mads@ynddal.dk>,  Jiri Pirko
 <jiri@resnulli.us>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Michael
 Roth <michael.roth@amd.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-block@nongnu.org,
 Ani Sinha
 <anisinha@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Lukas Straub
 <lukasstraub2@web.de>,
 Igor Mammedov <imammedo@redhat.com>,  Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz <hreitz@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH v2 03/21] docs/qapidoc: remove unused intersperse function
In-Reply-To: <20240626222128.406106-4-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Jun 2024 18:21:09 -0400")
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-4-jsnow@redhat.com>
Date: Thu, 27 Jun 2024 08:02:16 +0200
Message-ID: <87sewyj53r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Lines: 11
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> This function has been unused since fd62bff901b.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

I assume you won't mind me adding a bit of polish: "since commit
fd62bff901b (sphinx/qapidoc: Drop code to generate doc for simple union
tag)".



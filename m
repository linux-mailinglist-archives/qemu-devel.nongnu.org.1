Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2800AC711F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 20:44:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLk0-0005qr-H5; Wed, 28 May 2025 14:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLjy-0005qT-Ab
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLjw-0000IV-VT
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RGAKMVp0K0p4p6YGKPOWEyNxxdo1Jt0sV/VxaFZDwU=;
 b=g+2IfJ7YiUsnFmIzonOVfDGRxcMYuwUdN4LLjrPX5f3arORILKbqf0tc5uzUSmLDlEV4XW
 z2IIhz7WHd3f+vM5YghD3MBzEb/eaesjr5TIltfWwBH0i+T87DMvf0Y89gKUZGPMuZrNqo
 byXe/vo7N3OhVld0AnrccgpC1PdLArQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-cPH1qPjzPGeMF4wMmnmaEA-1; Wed,
 28 May 2025 14:42:56 -0400
X-MC-Unique: cPH1qPjzPGeMF4wMmnmaEA-1
X-Mimecast-MFC-AGG-ID: cPH1qPjzPGeMF4wMmnmaEA_1748457774
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92FDF195423C; Wed, 28 May 2025 18:42:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E7B319560AA; Wed, 28 May 2025 18:42:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 98E0D21E6757; Wed, 28 May 2025 20:42:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Fan Ni <fan.ni@samsung.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Kashyap Chamarthy <kchamart@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  qemu-block@nongnu.org,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Fabiano Rosas <farosas@suse.de>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Igor
 Mammedov <imammedo@redhat.com>,  "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,  Eric Blake <eblake@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Michael Roth
 <michael.roth@amd.com>,  Yanan Wang <wangyanan55@huawei.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,
 Stefano Garzarella <sgarzare@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Mads Ynddal <mads@ynddal.dk>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Kevin Wolf <kwolf@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/3] docs: remove legacy qapidoc
In-Reply-To: <20250522170219.58058-1-jsnow@redhat.com> (John Snow's message of
 "Thu, 22 May 2025 13:02:16 -0400")
References: <20250522170219.58058-1-jsnow@redhat.com>
Date: Wed, 28 May 2025 20:42:49 +0200
Message-ID: <87bjrcvaom.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> This series is RFC-ish and based on python-qapi-linting-v4, which I
> think ... should show up in origin/master soon(?).

Please use

Based-on: <message-id>

Out of time for today, or I'd hunt for the exact base myself.



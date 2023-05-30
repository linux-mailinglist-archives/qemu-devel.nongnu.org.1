Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C24716FB7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46sv-0004RE-7A; Tue, 30 May 2023 17:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q45eQ-0005HB-W3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q45eP-0008Pa-GB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685477340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eN34AIswrLxKAYU4zW7v0Fslw82VFhWKRBinWIzq9b4=;
 b=LX/uIALkMfBH8SkUrgyKoIRjPsVol4FK2AueETm8V41zb8yI9m1MYzuFQspSvIWB+ghrzl
 XoQ2HT3SfiJSp0CGLJVYpD8qehRXITMiqeCLE3d6R64PDjQnv1mN6EPzUJP0kjb8uYFpfQ
 jAlVGNkMQtpf5wb0j7ZYQfB93BDfK+Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-IwHwSOaDPWOlJaaqJ8GLeg-1; Tue, 30 May 2023 16:07:23 -0400
X-MC-Unique: IwHwSOaDPWOlJaaqJ8GLeg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af1589c75aso26012571fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685477242; x=1688069242;
 h=content-transfer-encoding:mime-version:user-agent:message-id:date
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eN34AIswrLxKAYU4zW7v0Fslw82VFhWKRBinWIzq9b4=;
 b=glQv9rVzADOT+WMx6lYF9Q1rkBBsARhgQXCHrxjsdkTaIhakQmq8R/8eI+RB8+ItBc
 A/L9qNZn4ybUyQysg1Uf1FWagWgif3vUXqr5n32IBlOjf1Q5sNYBQbSsPymwDCkbLo26
 pGOAp4189XjKGeORlHbwkeNRPFYTLBxfmdQffu5JKDMAXlF9I99xT1Zi7D8E3WbDBqJt
 q9Kc+DhMg0J8q7OV396b1zr6iUGUsNpZ9dwv+mMzJPqsmI0lGNmDVDwKcuL5ElRP42SY
 yV4OYm/szRaxbGcKciSFjcQqgQdGYVd4KXbHVfXLhzozhRiRqJXOSgvqQUSLCBnDM+Yt
 9vtg==
X-Gm-Message-State: AC+VfDwAt0iK1MsPcM1Fd1qnLxwM3abLotGgqJVRUs1SS2/Arva3jI/A
 m8ORIkWi5L1e176AfhMFKxYe+//OMwk+04zB1fTeucxBrUWYyCsCdUQvKkc/Z6b/sOyc44Mb6cj
 gv7q6I6PruS1+Qv4=
X-Received: by 2002:a2e:9c50:0:b0:2af:160d:888a with SMTP id
 t16-20020a2e9c50000000b002af160d888amr1543471ljj.1.1685477242310; 
 Tue, 30 May 2023 13:07:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6aTMMQQtwGITkoHpc4Ruk7/BxlMQneLtwbBg6Y/C4dSS1CRis5kUp3UKnK58JQrMcXPFpeDg==
X-Received: by 2002:a2e:9c50:0:b0:2af:160d:888a with SMTP id
 t16-20020a2e9c50000000b002af160d888amr1543464ljj.1.1685477242002; 
 Tue, 30 May 2023 13:07:22 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 rv3-20020a17090710c300b0096f7b7b6f11sm7726662ejb.106.2023.05.30.13.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 13:07:21 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
    stefanha@redhat.com,
    alex.bennee@linaro.org
Subject: [PATCH 0/4] Add SCMI vhost-user VIRTIO device
Date: Tue, 30 May 2023 21:59:46 +0200
Message-Id: <cover.1685476786.git.mzamazal@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 May 2023 17:28:00 -0400
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

This patch series adds a vhost-user VIRTIO device for SCMI.
It's similar to other similar vhost-user VIRTIO devices.

I'm aware of the work in progress by Alex Benn=C3=A9e to simplify similar d=
evices
and avoid excessive code duplication.  I think the SCMI device support
doesn't bring anything special and it can be rebased on the given work
if/once it is merged.

Milan Zamazal (4):
  hw/virtio: Add boilerplate for vhost-user-scmi device
  hw/virtio: Add vhost-user-scmi-pci boilerplate
  tests/qtest: Fix a comment typo in vhost-user-test.c
  tests/qtest: enable tests for virtio-scmi

 MAINTAINERS                         |   7 +
 hw/virtio/Kconfig                   |   5 +
 hw/virtio/meson.build               |   2 +
 hw/virtio/vhost-user-scmi-pci.c     |  68 +++++++
 hw/virtio/vhost-user-scmi.c         | 306 ++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-scmi.h |  30 +++
 tests/qtest/libqos/meson.build      |   1 +
 tests/qtest/libqos/virtio-scmi.c    | 174 ++++++++++++++++
 tests/qtest/libqos/virtio-scmi.h    |  34 ++++
 tests/qtest/vhost-user-test.c       |  46 ++++-
 10 files changed, 672 insertions(+), 1 deletion(-)
 create mode 100644 hw/virtio/vhost-user-scmi-pci.c
 create mode 100644 hw/virtio/vhost-user-scmi.c
 create mode 100644 include/hw/virtio/vhost-user-scmi.h
 create mode 100644 tests/qtest/libqos/virtio-scmi.c
 create mode 100644 tests/qtest/libqos/virtio-scmi.h

--=20
2.38.5



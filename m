Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6337CD69B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:33:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uy-0001qz-V0; Wed, 18 Oct 2023 04:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uw-0001o8-AJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uu-0003g8-Mz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxx0UVHYrb7uEEGRAehFsixsJ7Yl+etKGjOVzEvVFO0=;
 b=gEA1rVD3+ottRv9QTIMzUup3qCi8VRM/NiufjHDci5Ur3HI2w5+bre0QeFracThgnGlOcN
 vwMhyWA7VMNGe+HIdFc910SI5aVn/URn8x4SVG0MM91OC5pBGosgD1eQh2bWg+HMo2pTcG
 85bxbAQ8VGWIrWeiAFNAZacIA7ere/o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-X0EQ7mt6M2yG71_A3XnU6Q-1; Wed, 18 Oct 2023 04:28:33 -0400
X-MC-Unique: X0EQ7mt6M2yG71_A3XnU6Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53dd901c9c3so5123199a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617712; x=1698222512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxx0UVHYrb7uEEGRAehFsixsJ7Yl+etKGjOVzEvVFO0=;
 b=GSvqByryIkN81/j7eUJxF4QwqcEn2cwMZHmxeps62tzzJViydZeDt88S97elgioPKI
 26GecfxFi1C7CjVN2CkyZObAS8G3ECECU6gERajj41w1ous3wvVwAG7YmdplBgFQEZvF
 xTdrlxw38b6GnGd50zfi5i+QFTY1e158xDg8x8THNtQRQDb3pYZILksgz87zZdXSQlqF
 TWrrzwu7uhQMXsuukrPYV0YGZ3vYuHjJY3IS+kNOSuF8KAEXyJGPuFYoUXSJHZISL5Ij
 FP4II8tWsZsNGh3YT4aNzaps5oOFwLKtEnNBLYQjoxPs5vywJgU5Nl4eBXjmNqGVxLBC
 DAhg==
X-Gm-Message-State: AOJu0YzPbVtRWKDOFYl9gGLSIXGHXnyRdpmtlCj9d47hWKXwAdo6YHT4
 PuuUVoIrPF2In+024PaF9H7HE5pyfKSNm4cV+fWsVoS0p29z/W1di/avO3bXHJvbdPfXtURfcFG
 f4+9DhTf/w0cXDlyyRmZgKDAjrtQ7nS+0q3+IutXdxXRnsLh7KOIX97a6TfpuQnaZt09IJPUiw3
 A=
X-Received: by 2002:a50:cd4b:0:b0:53e:34c5:fc14 with SMTP id
 d11-20020a50cd4b000000b0053e34c5fc14mr3390324edj.23.1697617711807; 
 Wed, 18 Oct 2023 01:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwFljxnMZeJzAhAxtHs64AoCJlaJIDZmgt8BrtzVljHdhsEFjBicp3VA+1O4XIK0zCm5rkBg==
X-Received: by 2002:a50:cd4b:0:b0:53e:34c5:fc14 with SMTP id
 d11-20020a50cd4b000000b0053e34c5fc14mr3390310edj.23.1697617711464; 
 Wed, 18 Oct 2023 01:28:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 w23-20020a50fa97000000b0053e5edeff3bsm2346562edr.93.2023.10.18.01.28.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/32] hw/remote: move stub vfu_object_set_bus_irq out of stubs/
Date: Wed, 18 Oct 2023 10:27:40 +0200
Message-ID: <20231018082752.322306-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/remote/meson.build                                   | 4 +++-
 stubs/vfio-user-obj.c => hw/remote/vfio-user-obj-stub.c | 0
 stubs/meson.build                                       | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename stubs/vfio-user-obj.c => hw/remote/vfio-user-obj-stub.c (100%)

diff --git a/hw/remote/meson.build b/hw/remote/meson.build
index a1e8708c732..a3aa29aaf17 100644
--- a/hw/remote/meson.build
+++ b/hw/remote/meson.build
@@ -7,9 +7,11 @@ remote_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('remote-obj.c'))
 remote_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('proxy.c'))
 remote_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('iohub.c'))
 remote_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('iommu.c'))
-remote_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_true: files('vfio-user-obj.c'))
 
 remote_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_true: libvfio_user_dep)
+remote_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_true: files('vfio-user-obj.c'),
+              if_false: files('vfio-user-obj-stub.c'))
+remote_ss.add(when: 'CONFIG_ALL', if_true: files('vfio-user-obj-stub.c'))
 
 specific_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('memory.c'))
 specific_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('proxy-memory-listener.c'))
diff --git a/stubs/vfio-user-obj.c b/hw/remote/vfio-user-obj-stub.c
similarity index 100%
rename from stubs/vfio-user-obj.c
rename to hw/remote/vfio-user-obj-stub.c
diff --git a/stubs/meson.build b/stubs/meson.build
index cde44972bf8..0bf25e6ca53 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -65,4 +65,3 @@ else
   stub_ss.add(files('qdev.c'))
 endif
 stub_ss.add(files('semihost-all.c'))
-stub_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_false: files('vfio-user-obj.c'))
-- 
2.41.0



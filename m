Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511A73DAF9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiHi-0002Db-7V; Mon, 26 Jun 2023 05:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qDiHZ-0002D1-6z
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:13:13 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qDiHX-0006AE-Iw
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:13:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51cb40f13f6so3399660a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1687770790; x=1690362790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIcO5U8ojcl1qIugLnuh0W+nIgo2jy6fb1R5j5z42L4=;
 b=5qRLUwSTnkn3mtIOoxElfwCiHtC9mFu+BqsQIuVhoNf0nVb/ibBg4+qMvvem4srScc
 lKSuVHh3s4aU7voLW/gAw1KtG5vz7xcP3j2DVeyd1oQLtqdP+5I8FaTm1JNb9OmzERbW
 5/Te4eeN7mYE5iyjF0iNY2LKgqQXM50IV8f7oacuolGOrJLlQAJGN7RZz9QzCdtqvaZW
 mbx2KSw6Qj6N4u+IBWUx7SowJU8jaWyTU7wKSgtbPFiMmF+j0r8xpf+O5a0fz3nNdjEf
 ZRZdpvObysgggCvfKok2Ce6mdXH7amXNKM0oMs9h57f3QIWhvCrCGdMsLShYYPb6d5Uv
 oX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687770790; x=1690362790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIcO5U8ojcl1qIugLnuh0W+nIgo2jy6fb1R5j5z42L4=;
 b=ivuaTyTYb77sfnduEwyDySN9ADT/eqo9lRDydCmFyxLcv8IDxsym/lt3kGYqMSwHuy
 T1jnkxwTh23CYmhwXMxrwM6YwPli4q3RME2W3KQzmJVP0U7fa+ia66o0Xj1Unse45zNs
 YJfBRosqqPGuXaMkq0blav7y3O2r+0e8++hNviDKFTWcEcgqhNO4Ys6C5ThJkN7bbdDr
 /Sew+p95FHz+GzSUGTD2wQeban+PMX0vkW9l1LObp4gM5HrNrItHMuKgMYTO9Z4njTqF
 +fL2wqw6UN1sD4zKvpmQxTHsJGJrVpLRThCpacxStYyryoS75Mf+tB8EQafKOo8/5OlX
 AAkw==
X-Gm-Message-State: AC+VfDxHsaUw9TE9ubiSzb1P384Jk3CwvFJXQiFstZLFznvD3aTe/1cj
 2xuTekiQjV5qnr+EwRvFFHIzUQ==
X-Google-Smtp-Source: ACHHUZ5QXIRcLrPUjp6bh0dX7rJkrBabmO8hHqmI16DYZHANcRs3s0MpEO6GvAq5UVdVA326rg9aZA==
X-Received: by 2002:aa7:d058:0:b0:51d:9f6b:1b96 with SMTP id
 n24-20020aa7d058000000b0051d9f6b1b96mr556314edo.40.1687770789871; 
 Mon, 26 Jun 2023 02:13:09 -0700 (PDT)
Received: from localhost.localdomain.cc ([62.4.35.38])
 by smtp.gmail.com with ESMTPSA id
 i23-20020a50fc17000000b0051c7b5692easm2597693edr.7.2023.06.26.02.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 02:13:09 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com,
 Viktor Prutyanov <viktor@daynix.com>
Subject: [PATCH v5 2/2] virtio-net: pass Device-TLB enable/disable events to
 vhost
Date: Mon, 26 Jun 2023 12:12:58 +0300
Message-Id: <20230626091258.24453-3-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230626091258.24453-1-viktor@daynix.com>
References: <20230626091258.24453-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::536;
 envelope-from=viktor@daynix.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If vhost is enabled for virtio-net, Device-TLB enable/disable events
must be passed to vhost for proper IOMMU unmap flag selection.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6df6b7329d..30497c00b5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3951,6 +3951,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->vmsd = &vmstate_virtio_net_device;
     vdc->primary_unplug_pending = primary_unplug_pending;
     vdc->get_vhost = virtio_net_get_vhost;
+    vdc->toggle_device_iotlb = vhost_toggle_device_iotlb;
 }
 
 static const TypeInfo virtio_net_info = {
-- 
2.21.0



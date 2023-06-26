Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D7A73E226
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNU-0006Ia-FO; Mon, 26 Jun 2023 08:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlM7-0004Wa-I5
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlM4-0003EA-4v
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5K8h8NuJsIBhqIKCTOJ4P7gYMHEPEK+cfHdE8tyjHlA=;
 b=Q3RoEjLOmMnF8CGTi97CF/AkJuDBRUVZ9CewsovXe/kBte/PscKdQBlf33uopF+9KwfUom
 Jh6C9101u/8fdqHEdy9epltyd11EqITaA8jU09qoJe89jlLTJCP2W4W1Q+jxt6llnYorHA
 l8R/l1z5SD96lzOohdtW47xt0gCoue0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-7XFAwCbaN2aDq911qa_SxA-1; Mon, 26 Jun 2023 08:29:58 -0400
X-MC-Unique: 7XFAwCbaN2aDq911qa_SxA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f8727c7fb6so2241980e87.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782597; x=1690374597;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5K8h8NuJsIBhqIKCTOJ4P7gYMHEPEK+cfHdE8tyjHlA=;
 b=LHo1q520Si3VHusRnqoVGbJ0P2TfBmrTXthz8P4wVAtXouxnKSuO1HEv5CeUVDWX1A
 8yc6JGOi4ju4V/EfnX2SBvvgJn5Nkdix2iY7fnCwDvvXDoz93wgEMEJM3yTsZqFIl1hk
 Nzv2tRevltP9PgA4FikqUGlHTlROYkjZhxx1f9ka6eXAFDaeX6YL9nFuPFrNa/2vDoFx
 HExG2O5IJFvmktwgb/vepiHKPn9wyviIAtIgj5cu4oWLpLicOF+7X8vvKW7MAO9Uq7yg
 Tb8cxyQ/9/JJV7PW9XZJHiGsSS/Q9iMgJuyuROPECCqUbE6QY+51OaGjCjWTPJ4+aRlw
 NbrA==
X-Gm-Message-State: AC+VfDw7DyLM4QJM5RhPfDobjdYoydwQesF8IptxLhEduPsWC4O4Dfk5
 t/Q7hhVUxmhkIr2XMmpMmyH3JjhbuTElRnVqb+T8lzbI6cn/TamWVWSBBOwXL4w/2cdEjoJmode
 HHNOp3miUw1hVBD1SIBLQnjFm7jQ0dxX6ESmUnbFLANGSen3PRnS+fADyAvYLgBcASfy2
X-Received: by 2002:ac2:4bd0:0:b0:4fb:b11:c99e with SMTP id
 o16-20020ac24bd0000000b004fb0b11c99emr2159960lfq.56.1687782597178; 
 Mon, 26 Jun 2023 05:29:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5E3+DNbZ68UKyDbSk8nLGPaRex0ubDulc6bb7cnPYyjH5jYBa3edP8wdBJePKseswpGOXrwQ==
X-Received: by 2002:ac2:4bd0:0:b0:4fb:b11:c99e with SMTP id
 o16-20020ac24bd0000000b004fb0b11c99emr2159944lfq.56.1687782596945; 
 Mon, 26 Jun 2023 05:29:56 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 k37-20020a05600c1ca500b003f9b3829269sm16961699wms.2.2023.06.26.05.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:56 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 42/53] vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
Message-ID: <5b57ecdebc26e94fb45006f9a69dec853d1d0c72.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hawkins Jiawei <yin31149@gmail.com>

Enable SVQ with VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <778d642ecae6deed8a218b0e6232e4d7bb96b439.1685704856.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 99d0445d90..49221937a1 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -89,6 +89,7 @@ const int vdpa_feature_bits[] = {
 static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_CSUM) |
     BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) |
     BIT_ULL(VIRTIO_NET_F_MTU) |
     BIT_ULL(VIRTIO_NET_F_MAC) |
     BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |
-- 
MST



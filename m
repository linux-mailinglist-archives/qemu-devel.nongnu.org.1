Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 492567CE22F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:07:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wR-0000oV-1I; Wed, 18 Oct 2023 11:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ta-0002nM-E0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tW-0006r9-13
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axsLHZnyDqeJsUPQJ6Te7VvBOL93A3E/3UAHlG8ASYU=;
 b=GpXT4o5ElYXSEd/m9uMswnQkxvJjfBJyxqq4BTC9A7yZT/oTXIHACoCSAio7nrDOM1mceF
 RyA1oLMlx3lqmP+/iyumkNgFdisswT9SFKGGTSVWmyMEl9U4WZ/ic0Bq28sH87a1/3YYua
 dF/o9Ks4JlZHBayoq70uyeiPWPTmr2E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-g66TNcWbNcCTrIxMF0A3PQ-1; Wed, 18 Oct 2023 11:55:30 -0400
X-MC-Unique: g66TNcWbNcCTrIxMF0A3PQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-402cd372b8bso54058305e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644529; x=1698249329;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=axsLHZnyDqeJsUPQJ6Te7VvBOL93A3E/3UAHlG8ASYU=;
 b=ht8+5JDPA9D0RwEq7QoT+Fg7rhxA67gxEffgVGkE2mRP5SdNqCquwM+uwQA2bM7wfy
 8lRru1bD+x2z5NvMBD2le8TupsbhSo0QFwiFSRJWtHwKKllpA3WgO1n01kRiwI1lbITz
 3ZVRrnGTGc8DPRGsw7WnxrHtvKTCUDZJtRdufNBNfiEBo0SwIpVuia/ok2YNW4cDyuBp
 2YcMHnyWwZA5Aobe5nGsY5lCgbg/qbhWh5EdNnhZOInjkrs4ZDQDCec/7gIV6258j6st
 /ah2+qAeQ7L+yT+MPsdsk3W5SpLIRE1YbUEWMAhZEcz9ktQOximfIJHw5M1pKyyIesmu
 niNg==
X-Gm-Message-State: AOJu0YxG71cKxlzq82z5dowPw5ExkckvR1UtchcYQl7Nz7BngixIfDWE
 /eJJDkwm/hZPYykn1ljlr7bbmOCqDq2j3HndFHfzqww6hxA5vhsDw0PvP8IR4jKWCaLpCQmxhUo
 v09jTJDu30T/dWmoyEyZWOKkBJ+KLC+VI73nP0fgaUBII4R6Uz5DAv/xePoQjcgu+dl906PY=
X-Received: by 2002:adf:f447:0:b0:32d:a910:6c2a with SMTP id
 f7-20020adff447000000b0032da9106c2amr4220789wrp.30.1697644528953; 
 Wed, 18 Oct 2023 08:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiTU+xrY2Wa39hEO14e8sVy8tRgj/VZ+xYps/WCTf6Xjj58e5TvQov+JOr0BNbUfYQYEPGSQ==
X-Received: by 2002:adf:f447:0:b0:32d:a910:6c2a with SMTP id
 f7-20020adff447000000b0032da9106c2amr4220766wrp.30.1697644528598; 
 Wed, 18 Oct 2023 08:55:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adfb60c000000b00318147fd2d3sm2382642wre.41.2023.10.18.08.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:28 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL 29/83] vhost-user: strip superfluous whitespace
Message-ID: <b5d1fc465e97e2d8ff6ad86e986ea378978b8948.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Laszlo Ersek <lersek@redhat.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231002203221.17241-2-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 68eb1f0c99..3e33a2e9e0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -388,7 +388,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
      * operations such as configuring device memory mappings or issuing device
      * resets, which affect the whole device instead of individual VQs,
      * vhost-user messages should only be sent once.
-     * 
+     *
      * Devices with multiple vhost_devs are given an associated dev->vq_index
      * so per_device requests are only sent if vq_index is 0.
      */
-- 
MST



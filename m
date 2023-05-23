Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A870D3AC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1LGU-00009j-3N; Tue, 23 May 2023 02:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LFx-000054-2B
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:12:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LFv-0005H4-JE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:12:24 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f423521b10so44793435e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 23:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684822341; x=1687414341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQwCIhldMwC77ntdeaeg6sH3aScyUcbooXBZJsXEYow=;
 b=Yeb5fJ899eSOVzWUQqQyU1B7T8QMepA6aHQyF0ZqFxmvauCEok2oxk7EnRoPf4eW63
 ewHT8q/aPGmJM01UU54a5byzgyodo1ERoDAl6wn4WKTmB2L3nFSo6aLlFS08AcHXpWu8
 ZRFfHVTj7whIlD2+v/Abh7+bW9DJr9zV01nxlLtUWViDo5YzYBV30uC6j0aLh837X4F3
 xzTZAjyur9422cT00+ama/ZqWVJ5dOjbI2xaKzEbdqCl+OVHtAuYZuvqcWeF1YT1iesb
 Yqbi4fXITwtnVKnFI1DM34dBtrTE/dCh6AJx8rrcRwMkB2xapEyApiEYnBGaVhwwJlvD
 rMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684822341; x=1687414341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQwCIhldMwC77ntdeaeg6sH3aScyUcbooXBZJsXEYow=;
 b=Xq3+Ge8Hj3uyuHPxl6Ix9Y0EDafSVY3rNR4dR3suX4D8QD4li/wyof1fqlwQ6Xhj1n
 7T8orNaxnSFzrygTeOb1lDFt9v1dEJD7uiXE4oF+iTMzIx55lOt7WnrobymTi9Ss3xwW
 J/sMrNCim+Oe5mXYEpuVqpowm7/S1W5I79FyJer5fP4xbbbx8lqsU/fcejmS3/urF/m+
 eR2Rdl2tD2ZzN0tScpWXippme5DD0vvLMqJM6glI2wTc9+N5uIXpyoESRf3xsnhPLylr
 w/g9hmkZRp/ktFKCCk+tNDFR3/9lOySgpPBL3H349BajcBZJpbfODy5z3U4/jxdru6I/
 3R4A==
X-Gm-Message-State: AC+VfDxVislYWG2TrjP8PK4kcaTTsgxBmRfnxMc605Gw82b3S197C7+8
 MUZ2xq0X/n177zFhPALcvtf5PLnayCb3pJSbynM=
X-Google-Smtp-Source: ACHHUZ7X2Bpdi24QntO1VaFfirz/g7xOAk27Evvm0MohxWlFyE/F/I3i3sSkHCt4edBu6sMmsDbARg==
X-Received: by 2002:a7b:c8cb:0:b0:3f6:2d8:4823 with SMTP id
 f11-20020a7bc8cb000000b003f602d84823mr5043528wml.3.1684822341801; 
 Mon, 22 May 2023 23:12:21 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a1c7210000000b003f6042d6d92sm5888628wmc.46.2023.05.22.23.12.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 23:12:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/i386/microvm: Simplify using object_dynamic_cast()
Date: Tue, 23 May 2023 08:12:05 +0200
Message-Id: <20230523061207.48818-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523061207.48818-1-philmd@linaro.org>
References: <20230523061207.48818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use object_dynamic_cast() to determine if 'dev' is a TYPE_VIRTIO_MMIO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/microvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 3d606a20b4..7227a2156c 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -389,9 +389,8 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
     bus = sysbus_get_default();
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
         DeviceState *dev = kid->child;
-        ObjectClass *class = object_get_class(OBJECT(dev));
 
-        if (class == object_class_by_name(TYPE_VIRTIO_MMIO)) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO)) {
             VirtIOMMIOProxy *mmio = VIRTIO_MMIO(OBJECT(dev));
             VirtioBusState *mmio_virtio_bus = &mmio->bus;
             BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
-- 
2.38.1



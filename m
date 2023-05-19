Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64242709AAA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01TJ-0005u1-LP; Fri, 19 May 2023 10:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01T5-00050H-VA
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01T4-0003lv-DL
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkZgLO2ULCvim6XkvxIlN6Y1si/CGYQ9Gj9d57Tfixs=;
 b=AqJ3iK0hm6s0edAsTMJsLC+3LCxDQRv1v0f0OBq4goRnWeU56waehZhkbSq3bHaa18+SKV
 sJSDgHyt5ovTouE43qUyH0R0A4gitQS/bkxWtZ5Rc3Ljdg8AZQKPXy3ZZNFW4FVu5FUKXH
 G71W6xwP1szDV7FNgFtUj4bby2oRZOo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-avLj4-sgNDaw9lOok_3CGg-1; Fri, 19 May 2023 10:52:27 -0400
X-MC-Unique: avLj4-sgNDaw9lOok_3CGg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4ef455ba989so2144187e87.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507945; x=1687099945;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AkZgLO2ULCvim6XkvxIlN6Y1si/CGYQ9Gj9d57Tfixs=;
 b=aevI5QGvdEgY/0qPi9gojsVQscwjsKEy5nF8Gxk7Sx6c5ZLPBY4em67HiTy5CxNdn4
 b0bRKT3+sgdw31ltn61mhqbTt50KIvUSfM8mNU8yE058+cOM2Nx22fRtEZQGBeRzS9lw
 svXz1t2/2+s74U0EXU+n37fhcGlNnHSnzUavaYrjv7hWQt9kwOtKQa9UONgLsaPq8V5M
 8I7YSpUba5ldVgu9H13dtcHY5iNCPVha1t0eB60nJJVaNelbZ93V+jZ7kxlNfuJFiB6A
 SuxHPUVV7ai7uvocq69C4J2+wjmjp7/WfpxTVQ+lRI++F6Q7RuqiH1KOL8x919onxPsA
 QdOA==
X-Gm-Message-State: AC+VfDy3jMU6oeTTX9IWntukRFJT/1UfyfXFejzdKRckkuae4wg3wo85
 q5BZscXp6U/wBYrPg6rcsWSQTfgNPNeqK/qztZTOnPUkSAl7dN9XCKrXS8RrfhPYF6ALqpw5K4V
 0gBTZMPOfpIZCGktjPOdeknH5BtbQ+ScK5PD+9J8+A4OWjn9HHL+P/RD0+mWYk8HvPhXD
X-Received: by 2002:a05:6512:376b:b0:4ef:f4ef:a1cc with SMTP id
 z11-20020a056512376b00b004eff4efa1ccmr755977lft.14.1684507945268; 
 Fri, 19 May 2023 07:52:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4A+bXZ8eevLxogYXvyXCwUzwFiHbSmRQtP7gW3vX29PXNxd/QgsLXJkGcFgkSUMtJgBJ0evA==
X-Received: by 2002:a05:6512:376b:b0:4ef:f4ef:a1cc with SMTP id
 z11-20020a056512376b00b004eff4efa1ccmr755960lft.14.1684507944980; 
 Fri, 19 May 2023 07:52:24 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 f18-20020ac24e52000000b004cc9042c9cfsm626003lfr.158.2023.05.19.07.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:24 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 31/40] hw/i386/pc_{q35,piix}: Reuse MachineClass::desc as SMB
 product name
Message-ID: <1e366da0318bd9fb8cea66914e9682ad6e7d0a94.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

No need to repeat the descriptions.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230213162004.2797-5-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 2 +-
 hw/i386/pc_q35.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 66a849d279..a9c40201fb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -198,7 +198,7 @@ static void pc_init1(MachineState *machine,
     if (pcmc->smbios_defaults) {
         MachineClass *mc = MACHINE_GET_CLASS(machine);
         /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", "Standard PC (i440FX + PIIX, 1996)",
+        smbios_set_defaults("QEMU", mc->desc,
                             mc->name, pcmc->smbios_legacy_mode,
                             pcmc->smbios_uuid_encoded,
                             pcms->smbios_entry_point_type);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a76c2d4501..89e69737d6 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -199,7 +199,7 @@ static void pc_q35_init(MachineState *machine)
 
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", "Standard PC (Q35 + ICH9, 2009)",
+        smbios_set_defaults("QEMU", mc->desc,
                             mc->name, pcmc->smbios_legacy_mode,
                             pcmc->smbios_uuid_encoded,
                             pcms->smbios_entry_point_type);
-- 
MST



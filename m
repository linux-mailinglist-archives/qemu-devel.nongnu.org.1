Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E019745D1
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 00:21:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9Bl-0003FA-OT; Tue, 10 Sep 2024 18:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9BY-0001Fl-H9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:18:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9BV-00075R-7b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:18:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-718e1ce7e84so3016311b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006684; x=1726611484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVlIH0vLGwHmaRGMFANFNOikFJyMD1Z2/NyDN944UZ0=;
 b=j8CR3sr0tw67dbYksDjnaDQeBLYfY9+Izh4GgWxY17gWiYOc4IJl1Sg+YxA5bPD51y
 0K7AEa5o7Fbh2rlgdaknmaSdRDUaeepsnwnyd6iQFI6DHhDqD2wydVXc7SHHt2MyhqP+
 EA76B+ZkBSg8MsMiHjBJN8U+KWNCwQktx2uMxGTSjCcgnr2HFBge32z4OFhu+RqbNNwQ
 i35/X2z9DS5yed7GMwFJrzL1Umz5skcoL7tl8qPlcbumu+b4ydft0GfqZQnjZR567De7
 8It+gUA0f8Sqt450v65QW1ZvgEp5Jl2mcb6KXViFEzfSJc9cqePCZ8nuXKqbpIhLCuWh
 PslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006684; x=1726611484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVlIH0vLGwHmaRGMFANFNOikFJyMD1Z2/NyDN944UZ0=;
 b=CZs15Rmyu6x6YPgKWxlOMaqFI1Ct13EgbRX1pCwiQIhHFjVrNPRjNsUbamIIgeI5o6
 usAKXoNVX8TZ+I79ANmziG+zXW9pO8nEzggkSGYfaH/jz1vCEYBSU7yoxzaZsKHz2hPC
 F4F3zsCtWeH6t+WVUx2NQt37L+7emQvd2ScnFHo6wP4gFI4OPBUJ54iAEvxTH86t1+OL
 cLDHuwP+WDtHHlpsowTDcjHn1Q2KeZaw/H4objGY0t2eS6xAV2bWUnkfk1DqGkONU3Ut
 YkJjqGvYbJtbcw0jcv1bqIacW+aPv4EwFz1X2GN1pOsL9cHDs3GCuaVYEbxk2EYfjP32
 IE/g==
X-Gm-Message-State: AOJu0Yz61TltZbMYagRnXmBUvP11KMKmqpKlsSJMNR4bjguwLhOOIfwi
 szmgqgR0kqTd/IyEgWxCtiUhMnXP0+YnrvSFi7VULX/IUQFQMw7jqbw4d7wffwmgTFp2t5lqj+j
 4aTfjpQg6
X-Google-Smtp-Source: AGHT+IGmxzzneUTyXUzTC7HDyLbhq6XrgpPzar4wgVhFnulO1e/5MM9gmR+Gi+k9UlOi7JBGbi98dA==
X-Received: by 2002:a05:6a21:4a4b:b0:1cf:2df6:453f with SMTP id
 adf61e73a8af0-1cf5de0ef4cmr3537960637.0.1726006683723; 
 Tue, 10 Sep 2024 15:18:03 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:18:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 35/39] tests/qtest: remove break after g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:16:02 -0700
Message-Id: <20240910221606.1817478-36-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/qtest/migration-helpers.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index a43d180c807..00259338833 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -76,7 +76,6 @@ static QDict *SocketAddress_to_qdict(SocketAddress *addr)
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 
     return dict;
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A81697C3AE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Sep 2024 06:53:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr95S-0005Xe-LF; Thu, 19 Sep 2024 00:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr95E-00044Z-OD
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:48:00 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr955-0007b5-57
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:48:00 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d704704aso334316b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721270; x=1727326070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsHCjwrGb9kFALwWqgq3B+HDSbUQOfqxzvxaIUK0xNk=;
 b=pHmfWeW/FbkQ9KDlQ+KCFzWpK/+WnU95OyQIEhFTsgTCdwaiXmHxdcKAmLnRpIPT9Z
 B3QiE74Obi4+5cIS/dqxPgtz27d4X/aYYQFdkuUG+IhhHATNx1+LiguIZVdHtL80Pev+
 sTGVV1fB4k0D9YHoq/UjHcXkDfM09EemkAIG4gnNYR70eBeYW9rwhPigOYdBiGoeVr6E
 Llw7lSOowx0zD0VNH9aH8jJ0tdzB7WDo/O/zDpMsZI/nPfpVTEhT8/Wxd5m7xZGn0EzD
 cORAEwr+XMFdxusiuRomHoc3I3vwhnKqrASGnkpH6Xw0xb5Pmp0jZIQAckM3L4l10wQZ
 SDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721270; x=1727326070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsHCjwrGb9kFALwWqgq3B+HDSbUQOfqxzvxaIUK0xNk=;
 b=mntc/5wbA1xa8ERg5XiOTi2+WjFG86a4UK2Y3nv5SWaz8xWU2ByImGQaNmf9je9Irs
 9MasM7Sv0QVEhoJHzQCv3h7nq4x8HoUbfy19MVV9v8Xmz3pp+ouq0teK8/XphexZHbeS
 Ve9LbPwCIFeQUzUJ5mCqK2T3mPvwAjEu2jurJoat9ReZeLO6O8QrrafjL/h9qjm6C4w8
 Piv2Nda+O1KINA1UQqzGOu4bl5bqUuvmtQn5LIIn+ZWqFKDT/0b+tMHDhOZU5P4WPg+b
 s7oxrBCyuf89HvKrPWBPNlEoFfFgpQz1r/2l+2Xq6fWTR+tjb1aeek+vU1wyq5LwW7xF
 qrFA==
X-Gm-Message-State: AOJu0YwCgkdTzQjMbY9FLzVrdxoHyRtCj9dKbmXm5/z7wMrPTImg/R8c
 FC81nt//qoYuDSEs20z8EUO/tlC5PWip4BDaATNmeecRZSFJTHM44eM8tsukuJKRULKuhziA2cU
 qCMrAQw==
X-Google-Smtp-Source: AGHT+IGSEJfg9NiDwsfGQNgMzoJXvgeBnRfAVLKv9CjCjZDAdI9sAnhanA6KRSoF6muQ/s1OmrvU9A==
X-Received: by 2002:a05:6a20:cf8e:b0:1d2:bcba:70b7 with SMTP id
 adf61e73a8af0-1d2bcba78c6mr22172622637.27.1726721269821; 
 Wed, 18 Sep 2024 21:47:49 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:47:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Hyman Huang <yong.huang@smartx.com>, Halil Pasic <pasic@linux.ibm.com>,
 kvm@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>,
 Peter Xu <peterx@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Corey Minyard <minyard@acm.org>, Laurent Vivier <laurent@vivier.eu>,
 WANG Xuerui <git@xen0n.name>, Thomas Huth <thuth@redhat.com>,
 Rob Herring <robh@kernel.org>, Eduardo Habkost <eduardo@habkost.net>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Ani Sinha <anisinha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-riscv@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Weiwei Li <liwei1518@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Helge Deller <deller@gmx.de>,
 Yanan Wang <wangyanan55@huawei.com>, Michael Rolnik <mrolnik@gmail.com>,
 Jesper Devantier <foss@defmacro.it>, Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 32/34] qom: remove return after g_assert_not_reached()
Date: Wed, 18 Sep 2024 21:46:39 -0700
Message-Id: <20240919044641.386068-33-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
References: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qom/object.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 157a45c5f8b..28c5b66eab5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2079,7 +2079,6 @@ const char *object_get_canonical_path_component(const Object *obj)
 
     /* obj had a parent but was not a child, should never happen */
     g_assert_not_reached();
-    return NULL;
 }
 
 char *object_get_canonical_path(const Object *obj)
-- 
2.39.5



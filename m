Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC137F0860
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 19:53:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4mtz-00009o-OJ; Sun, 19 Nov 2023 13:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r4mtv-00008y-Ae
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 13:52:11 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r4mtt-0003gY-Jq
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 13:52:10 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc316ccc38so27343285ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 10:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700419927; x=1701024727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ejbEqFbr7avFbmFjfeMvr0ehDIwsw0t4r/DfUcHLu5Q=;
 b=GIPGR1O3rJrdHpaoFK8YdroGlNNklHnlvTTmVP4JjtIhchUzlbRn4Kq9MlVxK9xkRs
 BPk7/LzLBI7o2HjLVP4EGKyskcrzN/Qrb6zuAnDPLH+T4hcElNWi4m42UosHtd0mICTR
 FyZg8kPVpwkKJA8orgSdjQEypzl+z+UzPjG2oabEksRgXppVnQnUUd3wGJtdSrQjGhET
 pfV3CkCDB/pKvBcUqRBer2uI3FXyQ3m1hPE86ynNU1ER6lnyBD1wWirH4qS408QQBKeQ
 ZiegZ8a3kBF6GZySiY+WaU6IGyMu1WhMrowEU4VdfW1Re+9W0aDrZihIJIhcJA3DQ0RK
 iV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700419927; x=1701024727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ejbEqFbr7avFbmFjfeMvr0ehDIwsw0t4r/DfUcHLu5Q=;
 b=XguIep6xBzQ4QafAO/VNLcCXcF3m05dgqzsiy6n1AzctbY05I4TTcJTcTIslrbf2PI
 tA2Nbf5MBzpNQsOmUzrGeocnavgj2SkUc8SyAqTEw04r9T5QTs2VkjjzEFr3YxarcSgW
 7Q9j9GGObvc0MzZf1vZhBzxym2TpygxPQoEDkJSAaG9CGIfCqJWcDa8nNJV4zFGGsvkJ
 sjdoOap0K1mtkSVzO3bKjddYSD6thtJzBQjVNP3CTEwp1suP0eAsMEEPh3kWaS1IBcmr
 gV6c/Kb6e5BiD7d9bNp/1xJBNHOVKt0mMVUNDyUwEqnwvIBxinbgmB+xsARpr2cvZ1B4
 TwMg==
X-Gm-Message-State: AOJu0YzTAuH7MxfRb+Fjkixi+imVpUn4czQDzaId9yhn2R8HkwqVKKcp
 qsDnVu5AmS6+v/+jIjcyet2b0JIhb1w=
X-Google-Smtp-Source: AGHT+IErHwsiP/vhryd0JUKXbxWc2aMldjvGz1koeRobOOJFJP/9XT8ktAhHumNWI+7/G8fEH98/mg==
X-Received: by 2002:a05:6a21:9209:b0:174:7f7:d049 with SMTP id
 tl9-20020a056a21920900b0017407f7d049mr4668128pzb.9.1700419927269; 
 Sun, 19 Nov 2023 10:52:07 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:646:a201:19d0:85eb:a1c:1b3a:a140])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a170902ed5500b001cc3b988fd6sm4607665plb.265.2023.11.19.10.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 10:52:06 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL] target/xtensa fixes for v8.2
Date: Sun, 19 Nov 2023 10:51:38 -0800
Message-Id: <20231119185138.838278-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit b411438aa4ecaf4bbde90e20283e5899fec10f58:

  target/xtensa: Use tcg_gen_sextract_i32 (2023-10-21 19:17:28 -0700)

are available in the Git repository at:

  https://github.com/OSLL/qemu-xtensa.git tags/20231119-xtensa

for you to fetch changes up to 79cc6538fba73b3c071d76d912486e96540df98f:

  linux-user: xtensa: fix signal delivery in FDPIC (2023-11-19 10:38:07 -0800)

----------------------------------------------------------------
target/xtensa updates for v8.2:

- fix signal delivery in FDPIC

----------------------------------------------------------------
Max Filippov (1):
      linux-user: xtensa: fix signal delivery in FDPIC

 linux-user/xtensa/signal.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)


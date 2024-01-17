Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EB6830EB1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 22:37:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQDaq-0000xK-30; Wed, 17 Jan 2024 16:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQDam-0000x4-AS
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 16:37:00 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQDak-00020M-7L
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 16:37:00 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so8577904a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 13:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705527415; x=1706132215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g+wQlBySGzJrBjhHshVacT/3K/8LeLrcRFTEnF2L3J4=;
 b=NhQcYVdorwy7pjPt1cHbNUebtVPv7XFQ8TZQX2dqd7CWQ4OUq2/N+ig1n/W0KVwtd8
 XQxAcUnHQLo/LHakHyF4/AINYOVsJAF1eF294lGrDJEAOOCrC5hV4gh7IN/x2iYBt+k7
 7Nt/P6NyPLz9LAOBKkMaMH5MYL0YUeQIJT5RqxAIDDc3Y6kREG/96BBgdFQR+JdxoP06
 7WJqY1pE3g84zUDwDA0bQR03iOhQLgrBm3034PTZLShMSe9NmhoeRNwc0VvzizfHgI/x
 cgn4UEK5Z7TrNqsuW5ipBvtAMPBWVkoliVt1PX64br6CcsrMtGS1Le214G20ilQAzgS0
 496g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705527415; x=1706132215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g+wQlBySGzJrBjhHshVacT/3K/8LeLrcRFTEnF2L3J4=;
 b=vY23j298vvPZtVIArkN6cxBVqmz3oywc7JHNPeLDlL/El47QRZCOUdy7OuQuljMoz1
 GKC6bmTzalX0/9Xv3uQEtImB2qIkjzE8AbS/UNve1jXMtdSLXVUM+KVrgOTCK0i6DWBd
 jWO6aM0mgIkg5xHvYjHXakHIphCJhI4cSfTcYnbLPXc8aBkl+/Rxnp5cRpuAKoiJlAGE
 2OVPrNzBH5Yl+SrSzLm2RW1yUcNBKjrqLlV7GwZYGBJhU5Ls6i8MFxPhH7h9qcTfYt0P
 Np4p5MJkW1t/Mqn2KmHQFFcwpghGDAARHndWWml2ZbXaNn4ufa+wfgZgyXRtPh2ZSJQ6
 SB9A==
X-Gm-Message-State: AOJu0Yy15TMMEQzqy9+TfN4z4Ty9SVLetE0oqwfPgD6P/iDMm6EGoKZe
 kv1HeWZbc4U3oiBQxJg+K+FX9FBVVLlvpxPUIKZSDVscJkLCmQ==
X-Google-Smtp-Source: AGHT+IFoASF1Bd2QQ5wzXTFMzKM3/IPv25KpuqLKgm+u70czVroCzEAwhHyz0Kbuuz/f51mS05fPOQ==
X-Received: by 2002:a05:6a20:3946:b0:199:a6cb:20ab with SMTP id
 r6-20020a056a20394600b00199a6cb20abmr9849949pzg.123.1705527415536; 
 Wed, 17 Jan 2024 13:36:55 -0800 (PST)
Received: from stoup.net ([2001:8004:2728:321b:5fc1:fe4b:9b89:f799])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a170903410b00b001ca86a9caccsm104824pld.228.2024.01.17.13.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 13:36:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, thuth@redhat.com, david@redhat.com,
 philmd@linaro.org, mjt@tls.msk.ru
Subject: [PATCH 0/2] tcg/s390x: Fix chacha20-s390
Date: Thu, 18 Jan 2024 08:36:44 +1100
Message-Id: <20240117213646.159697-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

So it turns out the regression exposed by "Optimize env memory operations"
is caused by an s390x host encoding error.  This is the first time that we
have had sufficient register pressure to use more than a few vector
registers at the same time.

As such, the testcase itself is interesting, since nothing else in our
testsuite generates translation blocks with quite so many vector insns
with more than 16 simultaneously live values.


r~


Richard Henderson (2):
  tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
  tests/tcg/s390x: Import linux tools/testing/crypto/chacha20-s390

 tests/tcg/s390x/chacha.c        | 341 ++++++++++++
 tcg/s390x/tcg-target.c.inc      |   6 +-
 tests/tcg/s390x/Makefile.target |   4 +
 tests/tcg/s390x/chacha-vx.S     | 914 ++++++++++++++++++++++++++++++++
 4 files changed, 1262 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/s390x/chacha.c
 create mode 100644 tests/tcg/s390x/chacha-vx.S

-- 
2.34.1



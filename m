Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2447DEB6F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 04:35:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyOSs-0000Kg-He; Wed, 01 Nov 2023 23:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leohou1402@gmail.com>)
 id 1qyOSp-0000IP-TB
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 23:33:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leohou1402@gmail.com>)
 id 1qyOSh-0006UP-NX
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 23:33:41 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso506144b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 20:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698896018; x=1699500818; darn=nongnu.org;
 h=content-transfer-encoding:message-id:mime-version:references
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gaqe7hSpMVmgdPVFNLAm3Xl7Tsl/kyGbZCIuZbAWbi0=;
 b=RR0lppTc7iCxX0jEDRuJLItPWJLECUZ1v5/wRAGz3Elh5WAhanb7P2FPjwoLg2Iuuj
 6eyy53UP5r6ySoPYtS+6Ol3MO6+z4HWNfTWCSqlw+LU84VbdPktwrcC7Y4ihTDN1Zc5L
 ywAd+OhxzKatssQZDpW9vT9KRlhd87E7+5LJ6abbj/6oqN/V6eV+NBSCyJChsKUhUYjv
 a6wJeqIipcxaRnOlcivuPrhTHxLNGegIPDyGFz7Ot+Ea8ozrQ0t4QO/4Bhf7AaHyt44u
 0CO4cYSlOFHAWcZQnwqChrpTW2zbUX0uKIf4V1Bs2XrcL8+m0Pd+d6WwM1IxIHWMn05S
 4yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698896018; x=1699500818;
 h=content-transfer-encoding:message-id:mime-version:references
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gaqe7hSpMVmgdPVFNLAm3Xl7Tsl/kyGbZCIuZbAWbi0=;
 b=fEQ9dIxA0HvzcYL9/dkXBTP5vLo+PPFfVXnY9AbfhtLktsIJF74hEA2OlSPtwbMVZ5
 tQweYSCVEEqocv6xja7JLjgcbcoFaFqrODV/vSP0s74scszqwwhlvSFoI3rHWubx2gm1
 hrGFuqbEkP0DxCgwxl9aRCkrZ/Nnehl3YAuyVAR4a9z6VE/NQldIcMLPP+Nv0D20Y1Fz
 9M/VUtT4yDR/hk9BEZSNnjLMQCeQqNzBpaV+tXp22dZZzkpGsCYaJzeLBihNmOiQHTg3
 d/n6hcj3C9a99QAGkSd9+YYj0QnMkZtcL/TRUVYP3vzvEAgdOPJtzTVyueFoKw8Pm7B3
 IuMw==
X-Gm-Message-State: AOJu0YzhYJIwii80N5A4xwWgbJKV/yKI6Wx4ZMo7h3fEdRwGDb+Zx4AT
 L4mZ2398ngStMT2lVG4ioUU=
X-Google-Smtp-Source: AGHT+IFlb16PmkYSgPT05OOrXdEPXIpK8wWZllUjdFgYYQuwfVUcAsPFCQwB8vwVnRvpPvdTLn4XLA==
X-Received: by 2002:a05:6a00:1307:b0:6bd:8c4a:ab8f with SMTP id
 j7-20020a056a00130700b006bd8c4aab8fmr16506647pfu.2.1698896017682; 
 Wed, 01 Nov 2023 20:33:37 -0700 (PDT)
Received: from DESKTOP-2O3KOGU ([40.83.119.27])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a056a00271900b00688965c5227sm1855406pfv.120.2023.11.01.20.33.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Nov 2023 20:33:37 -0700 (PDT)
Date: Thu, 2 Nov 2023 11:33:35 +0800
From: "leohou1402@gmail.com" <leohou1402@gmail.com>
To: philmd <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: =?utf-8?B?5Zue5aSNOiBGdzog5p2l6IeqTGVvIEhvdeeahOmCruS7tg==?=
References: <3ab81ab1.1faf.18b8df8f26e.Coremail.leohou163@163.com>
X-Priority: 3
X-GUID: 27789758-A5A8-4C54-94B1-E153A657355C
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.228[cn]
Mime-Version: 1.0
Message-ID: <202311021133346289459@gmail.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=leohou1402@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

T24gMzEvMTAvMjMgMTY6MTM6MzIgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6Cj5IaSBM
ZW8sCj4KPk9uIDMxLzEwLzIzIDA0OjEwLCBMZW8gSG91IHdyb3RlOgo+PiBoaSAsIGFsbAo+PsKg
IMKgwqDCoMKgwqAgRG9lcyBxZW11IHBsYW4gdG8gc3VwcG9ydCBDUFUgaGV0ZXJvZ2VuZWl0eT8K
Cj4KCj5TaG9ydCBhbnN3ZXIgaXMgeWVzLiBXaGVuIHdpbGwgdGhpcyBiZSBhdmFpbGFibGUgaXMg
eWV0IHRvCj5iZSBkZXRlcm1pbmVkLCBhcyBhIGxvdCBvZiB3b3JrIGlzIHJlcXVpcmVkLgoKCgo+
SSdtIGdvaW5nIHRvIHRhbGsgYWJvdXQgdGhlIGNoYWxsZW5nZXMgYW5kIHBvc3NpYmxlIHJvYWRt
YXAKPmxhdGVyIHRvZGF5LCBmZWVsIGZyZWUgdG8gam9pbiB0aGUgY2FsbCBzY2hlZHVsZWQgYXQg
MnBtIENFVAo+b24gaHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZy4KPihTZWUgCj5o
dHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL2NhbGVuZGFyLTFhZDE2NDQ5LTA5Y2Mt
NDBmYi1hYjRhLTI0ZWFmY2M2MmQyYUBnb29nbGUuY29tLykKCgpIaSBQaGlsaXBwZQoKClRoYW5r
IHlvdSBmb3IgeW91ciByZXBseS4gSSBkaWRuJ3QgY2hlY2sgbXkgZW1haWwgaW4gdGltZQogYmVj
YXVzZSBvZiB0aGUgbWFpbGJveCBwcm9ibGVtLiBOb3cgSSB3aWxsIHJlcGx5IHRvIHlvdQogYnkg
Y2hhbmdpbmcgbXkgZW1haWwgYWRkcmVzcy4KCldpdGggcmVnYXJkIHRvIHlvdXIgZGlzY3Vzc2lv
biwgaXMgaXQgY29udmVuaWVudCB0byBhbm5vdW5jZSAKdGhlIHJlc3VsdHMgb2YgdGhlIGRpc2N1
c3Npb24gbm93Pwo=



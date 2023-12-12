Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDC980EA65
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:29:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD0wb-0004zS-5D; Tue, 12 Dec 2023 06:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD0wZ-0004y4-GH
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:28:55 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD0wX-0003rH-0n
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:28:54 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c39e936b4so32478865e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702380531; x=1702985331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2upU0FcSwAfpQs5BkNAQ22cY9mScW0fT9l3NBdPTmB4=;
 b=ql+Z00did9yELr8sQrOCXddWGm2i7TnGfZkmsyPcD1ezpHqBIsyrudL8DHX0ng8BLz
 Qcwo05eCxGrg+tXMuqXNrfK4BRtS6pKgVODJLBs6VL3+dszuE4dMplA3lFQozfCBwTkD
 e9AKDumfjT03T/Cr/FNLD2IveSh2JFnbtMZgfV+cYE8g2vrUKP+W24BIGZvPpe1t/b74
 YB3DOvP6+Hh+Ru882fPCtwLt4Dx2wavQCjUN4aKQ9S8WbLejuZnixNvFXnCIi+dmAt+H
 hHk4PEA6QJqE/Hkb6abC+JXqgneVRQYNwm1Qwyub0YKy6TxV9nmMXJ5zdunh57NdUxub
 rDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702380531; x=1702985331;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2upU0FcSwAfpQs5BkNAQ22cY9mScW0fT9l3NBdPTmB4=;
 b=SQD5TOSkGO4k1o/Kr7aLjafI5eOeCRxPmGcw8vFyfBNpgOY7S1ylVEZTW95dI1Sfev
 s5s7S3TfzxqgViv6+peN28BYV4aka/U3zTCnsAxEEOle+u0S0hyFUv29D3NDitxGHY1A
 dThB3XI7P7tzjv4TNenUqnu8+HMEdgz6daMHeiNwithmRg92WBP3vZE5P3XKs0gLQwO4
 HMIcKIQHdTs0oU/zkjcvFW31qNJwhlAp/SW8Kg4Bgywvkbv81zgLiWYFuYBzJJ+RMgA5
 Q+bu/GOIG1kXZdO0lUtdr1cdmYxyezE+NBKX3C0xuQ4CHKF/cOcwBIc4082+TYOWkwSI
 vnlg==
X-Gm-Message-State: AOJu0YzUfwXiBy4YF+B+opOXnk/NSi+DzPxd5MIhkvN9e8gUq8GfdQVk
 7vMP86BLaoZg6akBGdCyrnomyQ==
X-Google-Smtp-Source: AGHT+IHsRFUeS1XVov4om+zAK0ylCUp02w/jhj8o7/jlW5RfDJq0LxsBSP5ZOQTd+Ec7Bxlo7Tb1fw==
X-Received: by 2002:a05:600c:c0c:b0:40c:2b16:1f9 with SMTP id
 fm12-20020a05600c0c0c00b0040c2b1601f9mr1459358wmb.282.1702380531508; 
 Tue, 12 Dec 2023 03:28:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 gw18-20020a05600c851200b004063c9f68f2sm15942646wmb.26.2023.12.12.03.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 03:28:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB09F5F7D3;
 Tue, 12 Dec 2023 11:28:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,  Peter Xu
 <peterx@redhat.com>,  David Hildenbrand <david@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/4] accel/tcg: Make use of qemu_target_page_mask()
 in perf.c
In-Reply-To: <20231212003837.64090-2-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 12 Dec 2023 01:34:47 +0100")
References: <20231212003837.64090-1-iii@linux.ibm.com>
 <20231212003837.64090-2-iii@linux.ibm.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Tue, 12 Dec 2023 11:28:50 +0000
Message-ID: <87y1dzd5hp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Stop using TARGET_PAGE_MASK in order to make perf.c more
> target-agnostic.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


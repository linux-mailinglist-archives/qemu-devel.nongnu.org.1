Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0E380F8E9
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 22:07:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD9xj-00082x-6J; Tue, 12 Dec 2023 16:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rD9xh-00082p-IS
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:06:41 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rD9xc-0005jt-OK
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:06:41 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1fb13a0951bso2400887fac.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 13:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702415195; x=1703019995; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=idGZpHe4+svR+REdUJ27vNANpyKkVcaDRvULlpG0pZQ=;
 b=k9FM4UXwryffla6Gog6H46zkLzusBJkTJqozV5BgZ/u6lhS8p47W6X9FPakEzuSG0+
 VoNeaO9xrCVF9iTTABg/tSZ6qIo/k7UxelwC5W4x23vHjMsfNs3qtP37QOfh89bsnqa2
 InCC7R6BkaLq++nKIYSpVHzPDAlkAJGL/brPGRygiSyzhrW3/nG3Bv/Xn+0dGhtHHbsR
 2VeOcsvfqX81+J1bJCXjs9J2f8zNJvkQBCVV7LB/y9ww7sZritgsdoSMykY6gNSYxNkb
 yDyUpfnbp3xq00Tc0Y8pcfUgPjNBFHKfCqi5L6L54TWbTpoQ0YxUqaff5uoT81ddYXBA
 8W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702415195; x=1703019995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=idGZpHe4+svR+REdUJ27vNANpyKkVcaDRvULlpG0pZQ=;
 b=GKrMW8jegzyCBaTB45k9i7EqHxA2J8Vov20o1bhsmSvW/mUHercmN7wgug8++5aZ39
 3vRcfmSh3DGtDj6oqbJUl7jyCPH/XBaGTGz7mZU7YGTJtLhMzlM5Elk221o95QxvqR8Y
 ytj7Nk2qNQNhbcrI0TlbesKITd5+4dhFRA3DIXePDQMismXTrcDT9xbExCEaqQfhM5hb
 m+3iV1Ds7PT6S0RR2i7xYDyrTaw8eEwGyUovck67pspACcjiL6y1/2Rhnwu6Rk7Kwuy1
 cUkK/30r8YZL5Nf9DlwzfbAP8J5mtb+AyyNdqcXXi/rGRMfk382wL5NnNVvaDOXV516l
 xscQ==
X-Gm-Message-State: AOJu0YyMiU3Nv2JLkb3ho2VKxK8+mFKSqoPKjWK7Rfqe0jztEANwWEKi
 bPkbIvjFXtpdkA6TYAID/of+sZRdDx6KzHad6J8=
X-Google-Smtp-Source: AGHT+IHcfzw245oIveihrETNv58kO678nykWHYxegY9t5Sp6Vg//iDdaityEdOFsNY66zFRbC7swnlZacV8MRAUEiY4=
X-Received: by 2002:a05:6871:64c7:b0:1fb:a84:73b with SMTP id
 rk7-20020a05687164c700b001fb0a84073bmr3882709oab.27.1702415195436; Tue, 12
 Dec 2023 13:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20231212172510.103305-1-richard.henderson@linaro.org>
In-Reply-To: <20231212172510.103305-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Dec 2023 16:06:23 -0500
Message-ID: <CAJSP0QUhKT4gjZxEvLXCdnwaWma2D3yoa53LEmrB5LQGRFs3VA@mail.gmail.com>
Subject: Re: [PATCH for-8.2?] target/i386: Fix 32-bit wrapping of pc/eip
 computation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

I am waiting for review comments before tagging v8.2.0-rc4. There are
already other patches queued for -rc4 so we definitely need another
week before the final release anyway.

Stefan


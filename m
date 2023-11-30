Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374B7FFBBA
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 20:46:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8mzZ-000445-4U; Thu, 30 Nov 2023 14:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8mzS-00041o-Su
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:46:26 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8mzR-0007Jy-Dp
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:46:26 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c9b8aa4fc7so17751431fa.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 11:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701373583; x=1701978383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5jaemYcRn4/pBqbCndudYBCVOJZzXayR/s1I9ImqWI=;
 b=oEDK7ylhbTeLgF+JYaNNhxqHc0ySUckVbsP9Trblnropkf5wJaLOoQthRgSCBcInUn
 YymUfFGqIPcmcUoiL8U9mfkt0PTdlB7HUHsfVS1hmHB7jdF5gopWB25WhETv/Bx4/bKI
 8gX46rLT+1cd6L56czsw/uUs/JnhxXKATfWiZaH1frwkSOB0kLzDRyRcoElc+iTCGoMq
 wrNCqMYroKOUCOTUsTobFjFzxDbflts0xAeyuikEsN0GAwV8LHiABovkB5XUJeKA5jey
 zOrdfrZ97kyCvSelpzgthPcLKL9UrAKxfKigea4/eiyL/kwWGxX/Lu/ynuiQGGeLiaGZ
 pGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701373583; x=1701978383;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P5jaemYcRn4/pBqbCndudYBCVOJZzXayR/s1I9ImqWI=;
 b=tUKiPb3npKnMKcKbLgvtbqCdEXuUflsZ6sA9Xtz/i7EiAg1GZXdcINpFYzpYRzEQx3
 4Rf4lrtTO3X1UcAJB9uqlqQtzjbmuytxcvgl64yW4+TrD6s5ikFd/y7ceDKgc0j+V9Zr
 cBHhbS3IXZ9JMYMvN0v9dOXBlrm9eiIUFijmOBJiac/UoMXIVW9IRBSwWGe0wsWvTU5/
 MslwB1cdHljkZyLE00RNBWCPmLOJ47BEv2gzYXW5vTZIShRe48X64MDaI7EigrkNPZNW
 L+wU+6L/EExAenj8HKfY7PtLigL3+JPOi1HIaplB1/GeqQLS/LNuykNzCCtIgKwtrR88
 iXfA==
X-Gm-Message-State: AOJu0YxyzbuJtkncjs4ypk5BapexFmRSXP7NwCYpMp4Xhz2pzVGNA2+T
 fCgR+hbRyunbIZ2cG5X8qapsUb8sCuQz98oPNXqt/g==
X-Google-Smtp-Source: AGHT+IE9ty0p0UFHQ60xwF1xqod6ikGojEPRwLv7UnPjH484UgrUEbS+Q5i85MYlpHGnIw2TFDrO2g==
X-Received: by 2002:a05:6512:2310:b0:50b:ae1f:ff24 with SMTP id
 o16-20020a056512231000b0050bae1fff24mr113872lfu.31.1701364275748; 
 Thu, 30 Nov 2023 09:11:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c314900b0040b3d8907fesm2621507wmo.29.2023.11.30.09.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 09:11:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C7795FB51;
 Thu, 30 Nov 2023 17:11:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jai Arora <arorajai2798@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org,  pbonzini@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v3] accel/kvm: Turn DPRINTF macro use into tracepoints
In-Reply-To: <20231130155058.237850-1-arorajai2798@gmail.com> (Jai Arora's
 message of "Thu, 30 Nov 2023 21:20:58 +0530")
References: <20231130155058.237850-1-arorajai2798@gmail.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Thu, 30 Nov 2023 17:11:15 +0000
Message-ID: <87edg76ua4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

Jai Arora <arorajai2798@gmail.com> writes:

> Patch removes DRPINTF macro and adds multiple tracepoints
> to capture different kvm events.

maybe add "We drop the DPRINTFs that don't add any additional
information than trace_kvm_run_exit already does."

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

p.s.

It is helpful to add a mini-changelog bellow the --- line so reviewers
can see what changes have already been made to the patch. The git
tooling will strip this log when the maintainer applies the patches.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


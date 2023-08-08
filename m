Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 725D4774010
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 18:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQ2b-0004H6-Hq; Tue, 08 Aug 2023 12:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTQ2X-0004ED-E6
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:58:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTQ2V-0000aQ-Fb
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:58:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe2d218eedso50628875e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691513912; x=1692118712;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JdmeWIqCFc0bznABJFouRqL3B5cOjPEycZos54Pgr3g=;
 b=bAoan8qeTUxKuxoyohVPvsgic1xqILXelxx3eWiRzgSWtAKQ/iey75F/TMVbRDttEf
 Jgh10+grN6XAHig5Ou2uRqpXTAZoN1rZOdTFhcDdddtDlNIl060oKLO4Kd3r+9+THuGY
 4//TwaR8S23v2m9bmtUhn2issySHYm4N/bOKnmV3oBtANuipbd+vSt6mS7lfwGY8UY7z
 aQZTEM12rWvsx8izS6O7HK1eO2n6nLweyNMsROCR3LS1SFDCFi5AbbL8pEwBBogQ+CyT
 ZKoGDTRMVzKLFFwGEMEJLj0jeuAjI1aQYtj2xi1GxCBP0t6Si+uCzinpnrj4WVufFSwA
 Lp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691513912; x=1692118712;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JdmeWIqCFc0bznABJFouRqL3B5cOjPEycZos54Pgr3g=;
 b=cntlivRELQx1NczBbIyVjvMed4POu1S0uoTG8GniQMDDUwgLMgzcOs735hRHbidYym
 CCz8yGcGSRlxOMYH/2NYMTYWEjFzS1EHY03QbauEvEWrXss7sUV8bUqfQzbSJHR7Ub0Y
 Ykhgd6Dq7JAQvf2e21ux/8i7IWS60aKcl+6MbkGhwdsyOmseT1/s38kJPmwsp92VYaxn
 L4QRUAIYvZ7I5YysOHzQJHz/FgTtYbbVWqyxV8Rml6acntnZ1sWY14GgnUEZDFBBjef3
 ykKp8SobxlclP5+XWJPJZsnQhzpVwVxLdbEidYH4WbnbSKfHoyL05OixQo5+UzSo461R
 RdnQ==
X-Gm-Message-State: AOJu0YxR3veay2P42kN9SB+tVh4LFh2dWLLgH/4EligCIHcq5DT4ckQt
 1Uy3E9Dgn2Ts/Nw2uTAcc1fE6A==
X-Google-Smtp-Source: AGHT+IGToa07DXeWaXt8CYzAt/hYLU3CcTLZEEpEAS4R/e/C9AVsjdN9OfcbD5CYKNgkBOsPlNEUWQ==
X-Received: by 2002:a7b:cb4d:0:b0:3fb:a62d:1992 with SMTP id
 v13-20020a7bcb4d000000b003fba62d1992mr337171wmj.0.1691513911761; 
 Tue, 08 Aug 2023 09:58:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05600c21cf00b003fe577eb8cbsm8923481wmj.44.2023.08.08.09.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 09:58:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 111811FFBB;
 Tue,  8 Aug 2023 17:58:31 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-15-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 14/14] linux-user: Rewrite non-fixed
 probe_guest_base
Date: Tue, 08 Aug 2023 17:58:24 +0100
In-reply-to: <20230807163705.9848-15-richard.henderson@linaro.org>
Message-ID: <878ral79oo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Use pgb_addr_set to probe for all of the guest addresses,
> not just the main executable.  Handle the identity map
> specially and separately from the search.
>
> If /proc/self/maps is available, utilize the full power
> of the interval tree search, rather than a linear search
> through the address list.
>
> If /proc/self/maps is not available, increase the skip
> between probes so that we do not probe every single page
> of the host address space.  Choose 1 MiB for 32-bit hosts
> (max 4k probes) and 1 GiB for 64-bit hosts (possibly a
> large number of probes, but the large step makes it more
> likely to find empty space quicker).
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


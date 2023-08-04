Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C88676F8D7
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 06:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRmBH-0000zF-Pr; Fri, 04 Aug 2023 00:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRmB6-0000xu-Ie
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 00:12:44 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRmB4-0005bI-V5
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 00:12:40 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-563dfffea87so1153508a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 21:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691122357; x=1691727157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A0hhtBufaLC/Y2Csq4GnTGeRAb8yTH0yWHOg9oLXDvg=;
 b=H2BgDP2vIyhI/4OOPBYz5siaYIQkLijCoDItY/2ug/rcX5gnUCvYH4tXzkUdDjh5ue
 5ke01wIwtifDOqu3cDFZTeXl+R+GxCoVVbAws07Vdig+del7KUit2Pda5tS2Oxkaijlj
 jd9jfHTFTd2pOsVJj+/VnL7SCrFfCYFDu1ubzrHhsYCaRkBCkFzC/29mxYQMpuyTgug3
 hIgjJ8Sz11BAvc9BOHLfPvaCdnQk2tYf6i+8G6G4YES3CNaC88f8uYXUAwfBEDElnEfl
 abOb9mK1RvH7WQYs4xfcpcwevXxWztGalsAQS0S+SszLUmbIljnw388bK1jmvSBDd0Kx
 buGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691122357; x=1691727157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A0hhtBufaLC/Y2Csq4GnTGeRAb8yTH0yWHOg9oLXDvg=;
 b=bDB795RbT4jUwAiosPUb6ml/EelMFrJWsJ4T+A9Bj27QA7SNiabvHKv+Bju0fXIFLa
 pQJbfKz63uciL4mhBfj169zwHqjLtuOK901qiKMUHKXJKccfi1VZ8AyF/JALDB1p2onK
 ZMPFL4sh2K+MKJ1Q5CU4VfW9GmY0DVidrtjB4xeOkyA9bCJm7RjdxNXgrl+jTO+lhAnT
 Gq7pSiUXuoOPplFBASFameinb80L1bpVB+UQdWOmyll4VSrve0V047F2zTX9yuLkfgeW
 53v2dEM3sfduN9jVOGRgaUTAiPKhW1o+OVNxV2xV4sbApjhoG3uNSioOvI3p0GhPk+QM
 0mLw==
X-Gm-Message-State: AOJu0Yza2z9sCpiC9cwOJ5I93awSSh9OoT5EAXJwe8GDMFNzuiZobeAv
 1YUGEY/wuqNvJ8hICKpaJFgNFw==
X-Google-Smtp-Source: AGHT+IEEvKMyBZWmELSaPuLJAWMLBTKavhfX15+GllsRZDftFcgoqCYV/ASGkzoPVrx1lK2NSvv29w==
X-Received: by 2002:a17:90a:20d:b0:268:341:57d0 with SMTP id
 c13-20020a17090a020d00b00268034157d0mr675435pjc.6.1691122356734; 
 Thu, 03 Aug 2023 21:12:36 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:9d52:4fe8:10ce:5c3?
 ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 n33-20020a17090a2ca400b002680ef05c40sm658420pjd.55.2023.08.03.21.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 21:12:36 -0700 (PDT)
Message-ID: <67ef38d4-6cc8-e432-cacf-7597b9359f34@linaro.org>
Date: Thu, 3 Aug 2023 21:12:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/22] pc,pci,virtio,crypto: bugfixes
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1691101215.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/3/23 15:20, Michael S. Tsirkin wrote:
> The following changes since commit c167c80b463768e04a22fbe37ba6c53a4a08e41e:
> 
>    Merge tag 'pull-request-2023-08-03' ofhttps://gitlab.com/thuth/qemu  into staging (2023-08-03 07:37:17 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> 
> for you to fetch changes up to 15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd:
> 
>    cryptodev: Handle unexpected request to avoid crash (2023-08-03 16:16:17 -0400)
> 
> ----------------------------------------------------------------
> pc,pci,virtio,crypto: bugfixes
> 
> fixes all over the place.
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



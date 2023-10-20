Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 490E87D0FE5
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtouC-0006wm-Gb; Fri, 20 Oct 2023 08:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtouA-0006wS-DN
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:47:06 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtou8-0007Au-KB
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:47:06 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c17de836fbso10852981fa.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697806023; x=1698410823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0FNRC0svb6rvM15Q2zxeoZxKzreTl2F1zaLcQ30MTs8=;
 b=ToUcAtFZ4B/lwUol1OGNaP/A86VBWDcN1GghwJDOCF7Ub189/jwpj9kQtAuTfpYAxS
 fzf74HPCOjGJH/XXQ07eul3K0yJo4nrmiPB15q6aIda5+1LM7ltczxMOScXZUU1zPqS5
 EoJ3W9MHLLmyBsu4c3fuyew4yAlum2AVOWZm3KcsV8j4vcuPAU3HZfoe7NWNuNVGv7Vd
 pTb08Y0p23On6VK1FcRYMNGUIMopVIBwId83Suj0Rjl3lIHyfTPTk76qnJTlBCxjaxNG
 CBBLKuBHtCUHqXB6yS89NZQD8URuOUrLSsam12T8ExU7xcaRDbdA1sa34gHjfGwJu+pw
 qjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697806023; x=1698410823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0FNRC0svb6rvM15Q2zxeoZxKzreTl2F1zaLcQ30MTs8=;
 b=Ytifdf5kiihX1YCgccun/t+sYnJ4EhAL2XYgSzOgJ+aml+d+Vm0ftJ08H/XZ4fTxo3
 vEedF2d+BW2ByARJuFOjcl8e4t4l9Il0nfYb7V6eCRwo5dM8IjIP/I5c7pDo8uu9EACR
 LJPEekQurZ77Ww+BvMDqJoXRolGiHBINbLOu2D3k38RwWwsgVSA++mvsJ2bH5PPJ2Isg
 MvUP1KbTTkb47rGCeuY58CY75k6sHBKWBUzhRol63a2XZd5UOY5Q8lUKQuRSVFwQ82t5
 fo0fLnzl9WH68T8OiWMXAzQpiWrcyIHO1brBLWaDZCZvqsQae6drLiq4a+zn8yC8QzCO
 cjEg==
X-Gm-Message-State: AOJu0YxMz9JxhORaocn6PVzZvY9AQ1kEAPxdjMTQQaMUSr+k7UqtZI/o
 07A+YuFS9HscaBeKUaOEAth3Qw==
X-Google-Smtp-Source: AGHT+IFiAGbe1+WgTHkQ1avcGtrt4nXIfL1PSUTufWaZ6H9aSbEyGN2nOvdufohWOgAAituJIprApQ==
X-Received: by 2002:a05:651c:a0f:b0:2c5:31de:6c07 with SMTP id
 k15-20020a05651c0a0f00b002c531de6c07mr1998438ljq.14.1697806022811; 
 Fri, 20 Oct 2023 05:47:02 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 y34-20020a05600c342200b004063977eccesm6870780wmp.42.2023.10.20.05.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 05:47:02 -0700 (PDT)
Message-ID: <85dd082f-6068-9a8e-f10b-9e3011176fb8@linaro.org>
Date: Fri, 20 Oct 2023 14:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Extend entry to cover
 util/qemu-timer-common.c, too
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20231020062142.525405-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020062142.525405-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 20/10/23 08:21, Thomas Huth wrote:
> We already cover util/qemu-timer.c in MAINTAINERS - change this entry
> to util/qemu-timer*.c so that it covers util/qemu-timer-common.c, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, patch queued.



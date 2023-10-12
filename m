Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5367C6FCA
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:54:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqw82-0006tE-Vk; Thu, 12 Oct 2023 09:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqw80-0006sx-PP
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:53:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqw7z-0005Uo-7V
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:53:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40675f06f1fso13639015e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697118805; x=1697723605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FeR5yUAYqp2COCfckbhtsYwBLAhfkFBJlUkv690HxCw=;
 b=ZjJ02+RGK2ebvnjaQIwVdozACTPficAJQMichIjQyUa20pg/7nElLSGu+5G2iQ9Ypm
 jnRrUobkaXXf85ouJHltdC4erpgDnnYjgfrJbD5xpNnN5q1YZrRR71hA5BEBD5Wh9Ds7
 nFSvYbVGY8AdJ6wCEuGx1BRm2aEjaga5te37FLp1ELuXxG9hYEzAJZpV4oil7kIngZKQ
 Ge4m6nfEpki+2+0349g5OG18ABYYxn9ppO5lf1WjgcU/PEUw2z8Qsza/eMVfPJTODZ4j
 qRRe3gDgh668r3v2QiQU0a37Aoc9MaG+j2Roy7L5eRbA7ij1EFvCYPw32educF2SPdIU
 dDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697118805; x=1697723605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FeR5yUAYqp2COCfckbhtsYwBLAhfkFBJlUkv690HxCw=;
 b=vKiCzts0s2ovELiFsGtMVKXvlBw8Hi+Qv9I3QNoFDtqW1HPnL0nLCA4JmS2/wrbKpO
 OAkMmLRVk/OwM9ijb/f0E8YxpKsVzSqJNvpCqG+92WTkeIpD4wsTCK8X7K1VVHnagaax
 iUKXdqC4mKxkzCwalqNf+zELXpaYuZMjph+iVRzZtDxgyGRNPrlf+SkYPcpIuKBIUx1e
 qCgYBjJF9gcq0ZrobB4fe4P7swx2CnAEpykEIrWNEMigfudRP/UAqeELHiZ0NG2iOTjp
 UUnzaDBwMRPjR4HZoUPDql8V1pkoL+5Cur9s2HO54kLVezdUwrv1bZOzHI47EFZp272G
 1n8A==
X-Gm-Message-State: AOJu0YxxkMJJiPUZcL6NURvvP5/KgXqdzmNBEPNR7ISZmq2x7QKQboBM
 OV5V4DiWGxG67jaieQ7Nj/OlpQ==
X-Google-Smtp-Source: AGHT+IErJ7TQN5OQrYXk3ziDFr4adctlAiM/2+efMgItLTdH/LyZ1I3fWja++bKM3eYhCFcSmLiUCg==
X-Received: by 2002:adf:e48d:0:b0:31f:fa48:2056 with SMTP id
 i13-20020adfe48d000000b0031ffa482056mr17995570wrm.27.1697118805298; 
 Thu, 12 Oct 2023 06:53:25 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-232.abo.bbox.fr.
 [176.131.211.232]) by smtp.gmail.com with ESMTPSA id
 g7-20020a5d5407000000b00327df8fcbd9sm18587607wrv.9.2023.10.12.06.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:53:24 -0700 (PDT)
Message-ID: <541180d9-fb7c-17b3-ab96-c5afd2a61a33@linaro.org>
Date: Thu, 12 Oct 2023 15:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] migration/multifd: Clarify Error usage in
 multifd_channel_connect
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20231012134343.23757-1-farosas@suse.de>
 <20231012134343.23757-4-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231012134343.23757-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 12/10/23 15:43, Fabiano Rosas wrote:
> The function is currently called from two sites, one always gives it a
> NULL Error and the other always gives it a non-NULL Error.
> 
> In the non-NULL case, all it does it trace the error and return. One
> of the callers already have tracing, add a tracepoint to the other and
> stop passing the error into the function.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/multifd.c    | 60 ++++++++++++++++++++----------------------
>   migration/trace-events |  3 ++-
>   2 files changed, 30 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



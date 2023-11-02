Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D150B7DF44B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:50:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyY4i-0007Q4-NA; Thu, 02 Nov 2023 09:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyY4f-0007Pk-Sf
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyY4b-0003h2-K7
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698932962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+kLTSqaL+s7wT5bkXDkmpXa7XZIo+qyQ5V3nF+C245c=;
 b=cJ63Zkn/oLIyMSn1djGeRClXAMTh2OU2akd24BZi37L/p/2rRXme6hI3X5+p4QP1Awk/7h
 EYL0OCNlDRnyQUUz22RJ6J0huOtglvHNLW++G3FbEwlhbvfmLMHPu1uzFnL0pgONnhVaPg
 Lz3Jj105IPFN3pwg6xael/9aamZc9yI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-UXWUg2pgPTGcuuGG1T6-zw-1; Thu, 02 Nov 2023 09:49:21 -0400
X-MC-Unique: UXWUg2pgPTGcuuGG1T6-zw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5a7af473da1so2251347b3.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 06:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698932961; x=1699537761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kLTSqaL+s7wT5bkXDkmpXa7XZIo+qyQ5V3nF+C245c=;
 b=gGpzI+i4/W5r8PDqOwyg3niUGYzRWJi/4katSHjACqF6Kl6u9I5q1KNoMKmHZN4mmo
 bsx4GnKJV6BVLsJx2XoxQQ+cg+wJ3PaXz9ye3PdTwJrX/jyH0RRAR1IINP2AHbU6JM6a
 pXNzTaGMYzBdhBYvYKkxX+gQzuYZpLyw6Yf6YhR1NbtN9ul8DDWXawjFyCHRMPwyzPtG
 abZGFh95bNBA/cg//AoelmPJGtmXauJc4UdY27ZhJhw0uE7vFZwxDIgCFtw2VtLQ6T4W
 pZEA43SloMSX0x2qafLJuZwXIL2TmYm4Hce6VW5RxVdYtxvj6TAngzvF3mcW6xlLOpUf
 0c2g==
X-Gm-Message-State: AOJu0Yyw0OzyOtcmUUQeqLa9ZsYh/hw+GruTZnPzZx0Zfij+3e99MxZK
 l2rrJU1lt4nV1Reee8LQoy4LBKQaDuWKgrjN7FDtUrKaQPaL+U2I+NaCZSikrlerJ7zdG1hsSqp
 tg2faDOnKnZVvTGA=
X-Received: by 2002:a05:690c:3603:b0:5b5:9684:663e with SMTP id
 ft3-20020a05690c360300b005b59684663emr116541ywb.0.1698932960780; 
 Thu, 02 Nov 2023 06:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgKnodiQAyBW71nLpTfvZpSqiOptyGJMnapqRyOCiy1loz0CMMKRXC2UxyIpjH7D5DoaXdLw==
X-Received: by 2002:a05:690c:3603:b0:5b5:9684:663e with SMTP id
 ft3-20020a05690c360300b005b59684663emr116529ywb.0.1698932960524; 
 Thu, 02 Nov 2023 06:49:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 pp11-20020a056214138b00b0066d12d1351fsm2368118qvb.143.2023.11.02.06.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 06:49:20 -0700 (PDT)
Date: Thu, 2 Nov 2023 09:49:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, in.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 hiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, david@redhat.com
Subject: Re: [PATCH v2 1/4] exec/memattrs: Add iopmp source id, start
 address, end address to MemTxAttrs
Message-ID: <ZUOo3fGmqM/gVyTR@x1n>
References: <20231102094015.208588-1-ethan84@andestech.com>
 <20231102094015.208588-2-ethan84@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102094015.208588-2-ethan84@andestech.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Nov 02, 2023 at 05:40:12PM +0800, Ethan Chen wrote:
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  include/exec/memattrs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index d04170aa27..fc15e5d7d3 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -64,6 +64,12 @@ typedef struct MemTxAttrs {
>      unsigned int target_tlb_bit0 : 1;
>      unsigned int target_tlb_bit1 : 1;
>      unsigned int target_tlb_bit2 : 1;
> +
> +    /* IOPMP support up to 65535 sources */
> +    unsigned int iopmp_sid:16;

There's MemTxAttrs.requester_id, SID for pci, same length.  Reuse it?

> +    /* Transaction infomation for IOPMP */
> +    unsigned long long iopmp_start_addr;
> +    unsigned long long iopmp_end_addr;

PS: encoding addresses into memattrs is.. strange, but since I know nothing
about iopmp, I'll leave that for other reviewers.

Currently MemTxAttrs are passed as a whole int on the stack, if it keeps
growing we may start to consider a pointer, but need to check the side
effects of unexpected fields modified within a call.

Thanks,

-- 
Peter Xu



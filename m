Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2F7D8D06
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 04:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwCES-0003oB-C0; Thu, 26 Oct 2023 22:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qwCEP-0003nz-O5
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 22:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qwCEN-0001jv-OW
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 22:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698372345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Njeno4RAtp0aahNDURBK2ND0sCIy0sOQlo84qVH1djU=;
 b=h//Fl//JIFGGl8+p4R8KSBTQQwerAPK9RAir6Opb7Zr/4DHWraleLSpfDJJEv97KZsHWfv
 AiRZqKsQaqd3kv2iYUH/4ECLFZAltPi2AnzpQGb8JfuAtH/gKjT/oUuBEZeEX5r9uE5B8Y
 ZkX2j2jDpmT4XlzVtDI9aZfBbdrxrzo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-RL9QaQ_xNjq-PUp6ttW7_g-1; Thu, 26 Oct 2023 22:05:43 -0400
X-MC-Unique: RL9QaQ_xNjq-PUp6ttW7_g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7789f06778aso390807485a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 19:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698372343; x=1698977143;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Njeno4RAtp0aahNDURBK2ND0sCIy0sOQlo84qVH1djU=;
 b=iTCv/MJp4QXez5l6jwqb1rbIo9vhkLwyki9EYfzul8bHJP56DP5lbbNBrk+M1AGdfn
 /9uIU0kb03PK/Hk0oqjtzmcYizHW9fIKsICp21OVFnPg8O3gZ546TyHegGeU2uKXCISw
 eJcsdy1HQ/D+OLzo8PUpVV0IhAq7WOGEsdxv4DbHCo6NZvRpSndy6SvC/vSCMvxsrjsa
 sw5Xi1UuedYdEgc3ZBwPnDj2v9hY+Y43C+992xaC7L5YGetRE2y4YJWGqybul+2ePhko
 2r4hqxWH3QDZ/wLhxjEkEdAoOuQjvJtFc6YPSRcXSVVdC+2sIIxSEpIagSe3IvVLVmQc
 +uGw==
X-Gm-Message-State: AOJu0YzicMm1smOps0V9QD55HFMFDQ+NKjlXjH/5yebDeQaF+mGx4cgI
 nAyCEb4QXxq7PZGeIZzppKzdh5iW5Ms8E3+Rk4bdj6i67jNE2wIP2U8Bjb/b+tJddmrK45BvhDU
 Ft9VheB2b7pv4ls4=
X-Received: by 2002:a05:620a:31a5:b0:76e:f73d:65ae with SMTP id
 bi37-20020a05620a31a500b0076ef73d65aemr5734900qkb.6.1698372343231; 
 Thu, 26 Oct 2023 19:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUZcfilBcvQ+9roGRjW21hRyTptm/99Y4+On/e+9IKouFQUgMzcgRtgU/sB0zaX3/4tTywZQ==
X-Received: by 2002:a05:620a:31a5:b0:76e:f73d:65ae with SMTP id
 bi37-20020a05620a31a500b0076ef73d65aemr5734888qkb.6.1698372342966; 
 Thu, 26 Oct 2023 19:05:42 -0700 (PDT)
Received: from [172.19.1.246] ([192.80.84.35])
 by smtp.googlemail.com with ESMTPSA id
 px13-20020a056214050d00b0065d0a4262e0sm252016qvb.70.2023.10.26.19.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 19:05:42 -0700 (PDT)
Message-ID: <15a0462e-bf20-4fdb-a59c-25da94882cd6@redhat.com>
Date: Fri, 27 Oct 2023 04:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] tcg/optimize: Handle TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-13-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231026001542.1141412-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/26/23 02:13, Richard Henderson wrote:
> +
> +    sh = ctz64(val);
> +    ret = op->args[0];
> +    src1 = op->args[1];
> +    inv = cond == TCG_COND_TSTEQ;
> +
> +    if (neg && !inv && sext_opc) {
> +        op->opc = sext_opc;
> +        op->args[1] = src1;
> +        op->args[2] = sh;
> +        op->args[3] = 1;
> +        neg = false;

This needs to check the validity of (sh,1) as arguments to the extract 
opcode (and perhaps the opposite transformation should be done in 
tcg_gen_extract, when creating a 1-bit extract on a target that does not 
support it).

Paolo



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D485F51D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Feb 2024 10:57:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5pb-0002kd-EM; Thu, 22 Feb 2024 04:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rd5pX-0002kV-Jj
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:57:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rd5pV-0007bM-GD
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708595844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XbDLkBp3kI0s3DRlfLoo7jIUqdqFSYBYM2NRpXfk3o8=;
 b=WY7q3wHrRCyc+3KzAr3o2ODlowp0xtGZXBK8yfp+NDObUWlgNpmjABLX8QRrDozrwtQJ8M
 NgzFxLoY1PJc+hLZIvH/9mDE4Pex8gdpGgjVHTAUi66cKlTfB83W4hSA0/pPdlNTdpKmca
 vrvZ6FgDF/Ss8KbQu2CGAA/038hcMS4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-GhINzLssMB-MURD4cShxGw-1; Thu, 22 Feb 2024 04:57:22 -0500
X-MC-Unique: GhINzLssMB-MURD4cShxGw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3e94bbb22dso91123266b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 01:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708595841; x=1709200641;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XbDLkBp3kI0s3DRlfLoo7jIUqdqFSYBYM2NRpXfk3o8=;
 b=R5pwsJIysRhJqHb0L1LTXd4UQWOnC2L2QcfoNd4q0Tz/KzDrqnad5AFcEU03NU8L51
 eoWyT3L3UaWjXOL2opAtl9nZOMqYGNz/qHACd0IfE/cyN5U+kOy1jb3sVO5DShc4hE9b
 ah9ObWhP/zCRUE2endDMybeiDbgMW9geOuJU4FuemZb5iqGoYxeBO1Vd61wZYwN5uLU0
 s03jgqErem/lxaxbLyK3aotMq7G/zn0uH/dq5Wpf4IhsBT0E+Y6rai9XSy7wjmmLipoC
 o9VEieG0DDP50vyjmQHMfAEOCA4ly3//15HoaFHUGbh0sHpKss+dUwTedvSYQEMZ5gmB
 ppzw==
X-Gm-Message-State: AOJu0Yz3mPNu+8R294OunSK6XRBhhgquB6VzngrC4DADnfIvso4PublF
 zlKlhpvLXhz/gPeYVDbr6BiZ1X0JvYl+pYC6ox7CDFVYAdQNv20CLMQhwl7K7WiHrz+YNZcvM+R
 WpGJyMQ+h0wyszdW9dzOvL2WXggkQqlJoRhc76BbujRvKN2FYw/al
X-Received: by 2002:a17:906:fb11:b0:a3e:7390:4130 with SMTP id
 lz17-20020a170906fb1100b00a3e73904130mr7968354ejb.14.1708595841729; 
 Thu, 22 Feb 2024 01:57:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0eWmMykMIJ6//Q0nPbHJg189Jo9oL1f633TG9s+TX30Q4vXFsJ3/u3I8H2zWceNiJVkSH8Q==
X-Received: by 2002:a17:906:fb11:b0:a3e:7390:4130 with SMTP id
 lz17-20020a170906fb1100b00a3e73904130mr7968347ejb.14.1708595841360; 
 Thu, 22 Feb 2024 01:57:21 -0800 (PST)
Received: from [192.168.52.107] ([37.84.174.18])
 by smtp.gmail.com with ESMTPSA id
 th8-20020a1709078e0800b00a3daadea882sm5740027ejc.56.2024.02.22.01.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 01:57:21 -0800 (PST)
Message-ID: <30980866-7fe8-4900-a75b-01fe735e14e1@redhat.com>
Date: Thu, 22 Feb 2024 10:57:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Fix exception frame format for 68010
Content-Language: en-US
To: Daniel Palmer <daniel@0x0f.com>, laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <20240115101643.2165387-1-daniel@0x0f.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20240115101643.2165387-1-daniel@0x0f.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/01/2024 11.16, Daniel Palmer wrote:
>  From the 68010 a word with the frame format and exception vector
> are placed on the stack before the PC and SR.
> 
> M68K_FEATURE_QUAD_MULDIV is currently checked to workout if to do
> this or not for the configured CPU but that flag isn't set for
> 68010 so currently the exception stack when 68010 is configured
> is incorrect.
> 
> It seems like checking M68K_FEATURE_MOVEFROMSR_PRIV would do but
> adding a new flag that shows exactly what is going on here is
> maybe clearer.
> 
> Add a new flag for the behaviour, M68K_FEATURE_EXCEPTION_FORMAT_VEC,
> and set it for 68010 and above, and then use it to control if the
> format and vector word are pushed/pop during exception entry/exit.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>   target/m68k/cpu.c       | 4 +++-
>   target/m68k/cpu.h       | 2 ++
>   target/m68k/op_helper.c | 4 ++--
>   3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 1421e77c2c07..20718944b4c8 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -137,7 +137,8 @@ static void m68000_cpu_initfn(Object *obj)
>   }
>   
>   /*
> - * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD
> + * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD,
> + *      format+vector in exception frame.
>    */
>   static void m68010_cpu_initfn(Object *obj)
>   {
> @@ -150,6 +151,7 @@ static void m68010_cpu_initfn(Object *obj)
>       m68k_set_feature(env, M68K_FEATURE_BKPT);
>       m68k_set_feature(env, M68K_FEATURE_MOVEC);
>       m68k_set_feature(env, M68K_FEATURE_MOVEFROMSR_PRIV);
> +    m68k_set_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC);
>   }
>   
>   /*
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index d13427b0fe61..0fc591e618f6 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -549,6 +549,8 @@ enum m68k_features {
>       M68K_FEATURE_TRAPCC,
>       /* MOVE from SR privileged (from 68010) */
>       M68K_FEATURE_MOVEFROMSR_PRIV,
> +    /* Exception frame with format+vector (from 68010) */
> +    M68K_FEATURE_EXCEPTION_FORMAT_VEC,
>   };
>   
>   static inline bool m68k_feature(CPUM68KState *env, int feature)
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 1ce850bbc594..b09771672dec 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -52,7 +52,7 @@ throwaway:
>       sp += 2;
>       env->pc = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>       sp += 4;
> -    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
> +    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
>           /*  all except 68000 */
>           fmt = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>           sp += 2;
> @@ -256,7 +256,7 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
>                                     uint16_t format, uint16_t sr,
>                                     uint32_t addr, uint32_t retaddr)
>   {
> -    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
> +    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
>           /*  all except 68000 */
>           CPUState *cs = env_cpu(env);
>           switch (format) {

LGTM,
Reviewed-by: Thomas Huth <thuth@redhat.com>

Laurent, if you're currently too busy with other stuff, I could also add 
this to my next pull request?

  Thomas



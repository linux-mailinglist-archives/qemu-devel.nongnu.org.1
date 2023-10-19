Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 986997CF72B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:40:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRNs-0004HM-KG; Thu, 19 Oct 2023 07:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtRNn-0004FP-6R
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtRNk-0000CA-Rv
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697715603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wnAdQdiSI1nabacTbShmX7i/BSa6yCFAPRIRv3CfUu4=;
 b=VHw/81SaEmLcdsOiZqpX1QslqhG8t3qc+aFm71uncpl4rQkqCelC0x+uks/V53nEpdXTUG
 p4AebXwri6ZFuCwsnB3v7dos/NG23ppgJauvp+s1ipJUt4LrDl7vpZ7TpdDpVo521PqF8U
 secEdwyGeZ38vYeMtm/M9a7nt6BL7/E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-jW1gaSDlNamWZ94OleAA6g-1; Thu, 19 Oct 2023 07:39:52 -0400
X-MC-Unique: jW1gaSDlNamWZ94OleAA6g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5042eca54a4so8079128e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697715590; x=1698320390;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wnAdQdiSI1nabacTbShmX7i/BSa6yCFAPRIRv3CfUu4=;
 b=Y+xKWcUxLSkWNLeFFplZRAOkpOVgiIYtVUuP2jZNZ4Zp/myFrW7Y9WdgzZIFmuPY8P
 wtv9prMvzPhCrNvy14kqJIJNdZlVc/wRC7HlO9LltLF7pX9sGS6DX0nHJbx6O9mm4s0V
 QqG9tnG4FkKMP4bOaCu88svbshIucr4bxuV7kmOjgE5o5jK9jVHt2RtUQL6y2gMTV0tn
 axHYEpKTKdiYiAIw9q6wlBT/Rx87a5RAef1F0h7HkE9UANiO4nHvubkGJywOWcemSOg7
 0qT0iZnl+vqcCNq78dUcJNoNAwLYI/naPxCyd7vpOCHIr9XLaMxj0ZAYCMAi0shWSXGF
 IMBw==
X-Gm-Message-State: AOJu0Yz48kJ411ca8juB4LxAOsFgB1IrbKc08ZLwJr6M58XEYHQsZrYe
 SBA9B4JZ4j6TMUugojY/j/fcgZ4IEJtY6VwmX9x3KaifAzYMJldQDcm1g47ByaBc/Jh89bB0Eke
 +dTCKvUkCIci7gjQWQgrhBG7hAmwyiigOnks/6/kuxhMUtM9DBlaYbr/NniI7KwfKWNr4rU9aKw
 0=
X-Received: by 2002:ac2:560f:0:b0:507:b15d:2ff1 with SMTP id
 v15-20020ac2560f000000b00507b15d2ff1mr1178607lfd.38.1697715589829; 
 Thu, 19 Oct 2023 04:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSmQ6jWbCyFXc9MvebsrEQDjFHHHdgtYtbkXIkSzkDVy6tpuXZpK0AW4D/RQ5XpY7tZhSgWg==
X-Received: by 2002:ac2:560f:0:b0:507:b15d:2ff1 with SMTP id
 v15-20020ac2560f000000b00507b15d2ff1mr1178594lfd.38.1697715589325; 
 Thu, 19 Oct 2023 04:39:49 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 u4-20020a17090617c400b009b29553b648sm3298097eje.206.2023.10.19.04.39.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 04:39:48 -0700 (PDT)
Message-ID: <ed228820-4fbb-4e45-9ad7-25149acd5d92@redhat.com>
Date: Thu, 19 Oct 2023 13:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] target/i386: decoder changes for 8.2
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
References: <20231019104648.389942-1-pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/19/23 12:46, Paolo Bonzini wrote:
> This includes:
> 
> - implementing SHA and CMPccXADD instruction extensions
> 
> - introducing a new mechanism for flags writeback that avoids a
>    tricky failure
> 
> - converting the more orthogonal parts of the one-byte opcode
>    map, as well as the CMOVcc and SETcc instructions.
> 
> Tested by booting several 32-bit and 64-bit guests.
> 
> The new decoder produces roughly 2% more ops, but after optimization there
> are just 0.5% more and almost all of them come from cmp instructions.
> For some reason that I have not investigated, these end up with an extra
> mov even after optimization:
> 
>                                  sub_i64 tmp0,rax,$0x33
>   mov_i64 cc_src,$0x33           mov_i64 cc_dst,tmp0
>   sub_i64 cc_dst,rax,$0x33       mov_i64 cc_src,$0x33
>   discard cc_src2                discard cc_src2
>   discard cc_op                  discard cc_op
> 
> It could be easily fixed by not reusing gen_SUB for cmp instructions,
> or by debugging what goes on in the optimizer.  However, it does not
> result in larger assembly.

Oops, I missed Richard's newer reviews.  Will send v3 sometime next week.

Paolo



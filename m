Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA479D84F9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Nov 2024 13:01:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXlr-0006LO-JQ; Mon, 25 Nov 2024 07:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFXln-0006Ix-DM
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:00:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFXll-0007XD-RH
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732536044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H4QFO+c/Wbkf/eCyRBJLfoDTzjZXGJ57g2g/hvp5FtQ=;
 b=Bcph3tThWe3H0e75gEl5uzUIu1laV3xruMgzVMEXKGy8IP16qGU/watC4zBN/arcK1nPL9
 Y38JYlK78HvgRZ3FW8Y/quH+pJ2vM7XbAdmsksZRJ3SwtC9kzLSQGchU08wmDtj7FXo17Z
 gXTbZtPNjgmfShj+awlxbJLSd4x6P30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-LUW-XN-4P9m0Nt--JaHwdQ-1; Mon, 25 Nov 2024 07:00:42 -0500
X-MC-Unique: LUW-XN-4P9m0Nt--JaHwdQ-1
X-Mimecast-MFC-AGG-ID: LUW-XN-4P9m0Nt--JaHwdQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-432d04b3d40so31039155e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 04:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732536040; x=1733140840;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H4QFO+c/Wbkf/eCyRBJLfoDTzjZXGJ57g2g/hvp5FtQ=;
 b=wvEWQj72TlJTwNho789q8wOpKeoc3kXwCCC0oP+gXSO3BDu7FP90JEQ9FNFa/gCxUd
 LG75tZpn0bgrSzLDEmT8v1LSnvyYE2YZPeoWd69bx+OaVvqjmilZHN3RIidrztlnUIrZ
 B4RzSdXYSiZXyHTLleki2CsaieS3iGo7JGD2CP/Qr4SP2/0n/+SnBwJPjqklWmgMTk7f
 eDU/j9M/uD32OhOpbbsEUpz4TFyYHJI+FhDiy1dJisTah/rstO3LjGfZ8Q2t+gzUS0xU
 32y9NV+GCGACByyTpyKuis7Q0Xt2y3DkH9b80S51Jh/waOD3kSTQ/SWM56I4CFUsk0rn
 CHSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXotleaQbQGKv46SeSysPsLR6TAoxxyAXKv7nxwvzRhK2qJ2UnaItaACVeGL6Y7BYEwXTxVW+4BqIHU@nongnu.org
X-Gm-Message-State: AOJu0Yzq1JT+MIqZic+BiYRUL91zt1jiI6CUxjf7d61CrFm3InYSwj+X
 dx4upTVF7znq08XxzT/Z/gRoNuBWYxSMQheu8h9k0j1TaBFOugLE/E8GmLK8fcv4v3/MRPBB1gc
 Ayxg6tD4bZvPd3voYu7muh+ptrLnOGP+IURFFPN3Ie/pROmbza+wn/oLxLi8l
X-Gm-Gg: ASbGncvwntdSZ4L+u3S3xey07kNpMK1un2RlEs3Vc9qP0ZgdWElqPol12zcnY2VLZGu
 NXGAgb03CkXbyZXZSUgYwKL3iy6OOU8PkfI022spdcqLMi6UxXRPL41xOEhXf90dVs20nJC36JX
 Mz/hnl4ffee13rsma0wuwYRlrYx77j+1yRL79597n9KyZt/jnFxUh5StGeVRFXQRqIfAqbhSdYK
 PyuVQLlfKoZTm7mjoMPi4Sa9wudRLWOmIMoj+aCNwfSXja0SgMlPw==
X-Received: by 2002:a05:600c:4684:b0:42c:ae30:fc4d with SMTP id
 5b1f17b1804b1-433ce417fa7mr99297315e9.7.1732536038800; 
 Mon, 25 Nov 2024 04:00:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhC4lh/5QJ0t5FCFmb7zEL3idRB26XyQoP86SRmep2pNvUJOTS39a0l4E1s6S7LxvUTBl6XA==
X-Received: by 2002:a05:600c:4684:b0:42c:ae30:fc4d with SMTP id
 5b1f17b1804b1-433ce417fa7mr99296885e9.7.1732536038349; 
 Mon, 25 Nov 2024 04:00:38 -0800 (PST)
Received: from [192.168.10.3] ([151.49.236.146])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-433b463ab44sm195181935e9.30.2024.11.25.04.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 04:00:37 -0800 (PST)
Message-ID: <689a4c48-af1f-44b1-9575-56c75ec0b830@redhat.com>
Date: Mon, 25 Nov 2024 13:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 37/43] target/hexagon: Make HVX vector args.
 restrict *
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-38-anjo@rev.ng>
 <30a70eef-01ac-46a2-8e34-458c579dcf27@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
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
In-Reply-To: <30a70eef-01ac-46a2-8e34-458c579dcf27@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/25/24 12:36, Philippe Mathieu-Daudé wrote:
>> +#define QeV      (*(MMQReg * restrict)(QeV_void))
>> +#define QdV      (*(MMQReg * restrict)(QdV_void))
>> +#define QsV      (*(MMQReg * restrict)(QsV_void))
>> +#define QtV      (*(MMQReg * restrict)(QtV_void))
>> +#define QuV      (*(MMQReg * restrict)(QuV_void))
>> +#define QvV      (*(MMQReg * restrict)(QvV_void))
>> +#define QxV      (*(MMQReg * restrict)(QxV_void))
>>   #endif
> 
> Maybe we need to fix scripts/checkpatch.pl along?
> 
> ERROR: "foo * bar" should be "foo *bar"
> #31: FILE: target/hexagon/mmvec/macros.h:26:
> +#define VdV      (*(MMVector * restrict)(VdV_void))
> 
> ERROR: "foo * bar" should be "foo *bar"
> #32: FILE: target/hexagon/mmvec/macros.h:27:
> +#define VsV      (*(MMVector * restrict)(VsV_void))
> 
> ERROR: "foo * bar" should be "foo *bar"
> #33: FILE: target/hexagon/mmvec/macros.h:28:
> +#define VuV      (*(MMVector * restrict)(VuV_void))

I think checkpatch.pl has a point here. :)

Paolo



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521E9D5277
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Nov 2024 19:25:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEBr6-000655-FP; Thu, 21 Nov 2024 13:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEBr1-00063X-HQ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEBqw-0007GV-8Q
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732213468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UJ9jAgXwMVHVFrUHaMWSAua/SnuMR5IMbLdDDB2um/c=;
 b=S/uFi4b+Y+3D+3jOsAXLvqGzSnA4JupW34CQVuKzNZsUcsh+hstiqls79lBtricQhdxLNn
 iVtambKOfDlvMHI1e58Doxon5+VPwh89u8rEorEWBW4IIjMVLe3R5uQsSV8WNLQ+LjzjI6
 SiYn0MlzhW1TcR4+8BHxJ4GUCH5DThs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-W2eUXq0MPjO7sS6NEC_4AA-1; Thu, 21 Nov 2024 13:24:26 -0500
X-MC-Unique: W2eUXq0MPjO7sS6NEC_4AA-1
X-Mimecast-MFC-AGG-ID: W2eUXq0MPjO7sS6NEC_4AA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso8050775e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 10:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732213465; x=1732818265;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UJ9jAgXwMVHVFrUHaMWSAua/SnuMR5IMbLdDDB2um/c=;
 b=eQycxBC8DL+vUMtQeVC+SREVzyUj+Tg36PJnt3/LCk7ulr0cTynu7Qij9ODcAwzGsN
 hm9OVpPuNLhkmVJhqNi58CThsxMsF6ChGsZGf8qhGn0zFbzE1HmQuSoXVveEcMH6FsIB
 t5YcO0NCEZYPKCffzqT94OdCjVLzR+EbDy+50Ci0IrJjR2PxICSSeAOS1asHfUvihaiF
 6tA5tB45Cj09Iz0BGiH4U1k1UryJtEipjU+wwRdZwozzN/16RCXqCz/uF2F/OQa5srQj
 3dYAR/j+Dec4B+FiEJI4gW/h+CutLmZnyNX+iFbM8E+qVWjlwoJ5qBcsIUcvsyVRmz5n
 8CEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAuWFXE/PeMEWgi8paNYhM6tJijbWCHrJ3MogjCuq5SlsIPtSiQRXGV+b84axkN4HRcACQ/hxhwFOR@nongnu.org
X-Gm-Message-State: AOJu0YzWZvHmW2Rl/5TSqIX4VUtPDER9bxCzHdlrRCOja1ypv56jTwFz
 O3RCTZTC3wTxa3UdVY/hl8e8zRe/IU89ax0R9IU8HgI9JEtfAPs8mt5MWjYF3cXjYxtj9wacscl
 HuUms+Qq+/N3pv1+t2YfFMqVf+kwBvc4a7mH+waIySCRW+wE6dZoI
X-Gm-Gg: ASbGncv4Gyo9z9PfDmLzHrC8UGOpIYLcl93NWODZZhINSbc9RDxmPMU2uMDvR7ZJUMv
 bW8RPiCOTp5NQb1eZ/BO2B+BRzSRfzmBKNtho+Vio7GB9jyfQXfjI5RyCU081z+6ceD+XaBDBEg
 630spMkLV36dFpwKTo+3uUfuC0A/iE6n2MLVP5zXwe8zg9WTpiSlJkpnVyO1FdRNKcRL94Oflzx
 8aV0UFU1Ak3uysk9RNCx56YKJTlih+qmnHlnFLrgpSLNZy/i4gIdg==
X-Received: by 2002:a05:600c:4f08:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-43348986a08mr66391335e9.6.1732213465585; 
 Thu, 21 Nov 2024 10:24:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8xiQlp54xG3XHDHxhViWwSoiqkq/1ywhOAV4GoL3Cb4arxAv3Fcp6ekpKROPIaYM2Us/qvw==
X-Received: by 2002:a05:600c:4f08:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-43348986a08mr66391095e9.6.1732213465134; 
 Thu, 21 Nov 2024 10:24:25 -0800 (PST)
Received: from [192.168.10.3] ([151.62.196.119])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-433b4643100sm66706405e9.39.2024.11.21.10.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 10:24:24 -0800 (PST)
Message-ID: <f45226a9-7664-41e7-849d-e8939f692d49@redhat.com>
Date: Thu, 21 Nov 2024 19:24:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU patches for native windows support through clang-cl
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Erwin Jansen <jansene@google.com>,
 Roque Arcudia Hernandez <roqueh@google.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, sw@weilnetz.de,
 lvivier@redhat.com, Patrick Leis <venture@google.com>,
 Nabih Estefan <nabihestefan@google.com>, Danny Rosen
 <dannyrosen@google.com>, JP Cottin <jpcottin@google.com>,
 berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <CAP52u7a_CA-PEw2gMgc32rCKGt8mqsjCkEedkzTgOosazrTs-w@mail.gmail.com>
 <61ca5164-3d81-4e2c-b581-304cf3cdecc0@linaro.org>
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
In-Reply-To: <61ca5164-3d81-4e2c-b581-304cf3cdecc0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/21/24 19:17, Pierrick Bouvier wrote:
> On 11/21/24 09:36, Erwin Jansen wrote:
>> The Android Emulator team has successfully ported QEMU 8 to compile 
>> with clang-cl, enabling Windows compilation and better integration 
>> with the Microsoft ecosystem. This involved:
>>
>>   * Replacing shell scripts with Python for enhanced Windows 
>> compatibility.

It would be useful to know what scripts.  configure? :)

If it's just scripts/make-config-poison.sh or scripts/qemu-version.sh, 
no objection at all.

>>   * Implementing fixes within existing scripts.
>>   * Introducing a small set of header stubs and a series of compilation
>>     fixes.

If you can add this configuration to the GitLab CI, I don't see any 
blocker.  Otherwise there's risk of bitrot.

Paolo



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA18AD4D8E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Jun 2025 09:56:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPGJ1-0005iW-MX; Wed, 11 Jun 2025 03:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPGIy-0005hk-Rn
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPGIx-0006SD-Dr
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749628525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZDlB+8IwLOkwf93Y9Ek8UvFKGDkuIQK6hQr3WuALH5g=;
 b=G5JmVDRL8NZOaoDJjEz3A75kzc94Y9l4hGkORisgwjtSth60BmIxlr/cErbtNOUZ9k9eKM
 pUIyXYze3YOyufDgvJ2BXkYyI/vGMQUZOTSWqRSADtyUf6CP35LhEZZwxBRh6urg60/N6E
 5Dk/V2ZOT9Q5oZmbf1jncU83TlBqKAc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-aLXLXMCjPS20bNkDguYHhg-1; Wed, 11 Jun 2025 03:55:23 -0400
X-MC-Unique: aLXLXMCjPS20bNkDguYHhg-1
X-Mimecast-MFC-AGG-ID: aLXLXMCjPS20bNkDguYHhg_1749628523
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a523ce0bb2so3305165f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 00:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749628522; x=1750233322;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZDlB+8IwLOkwf93Y9Ek8UvFKGDkuIQK6hQr3WuALH5g=;
 b=Rlwvv/Lzfd+36hRHxWRimYOpET7R1YLp/SNUwvYeVMoAiqb39ogx4ixerWMz98YIpp
 2/ybplpUCzxeBqRcy5HN+YUSi/Yol80GRjY02hxyRQlqtLli4HkkMzpjD3LANuN2hK7Q
 hXSEDpxQaYA4lEWU41mP/mcfa3USp3vWWy54F0ZTBvBkFpDT1PgCDjiTvugNHp+2rZ/4
 AEnby7kQW7rrHBRP6P471sp0o1oUqyLCSFQUpJkiAmo1pS+Lx4rfU4wN0j6kODLh+yhl
 +tcR3IRymOHqKjFkXquOjUTxkhTrSLy8PT2gOC1eX4hAIcpT7vyQlFJS2OqVtVYttdrR
 gQ0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDBDpIlVeRZCgkqN/ow4AtgC9GCCuvM+JM1aSAe9pz/T2iMxNqM/fX8irydqrk24E+UcNa3OOZqi1d@nongnu.org
X-Gm-Message-State: AOJu0YzVKAkClBJUl75ImvZXLIm45M4DDCxtxpuWCEaNxUx9saU1+YG7
 0JauINYB2HHeBWkMdhLZYsqnRATSnqWKAK36U9u3uQoaKWuaYVwpRdJWEklSKc3CAPAuKy9k8iU
 VVXjAF2sN3WlesmVYbvcv7dmU9yBr5pvFONguXNPsMAXXJPHMsc7fk+ld
X-Gm-Gg: ASbGncu/5kKfLzxs2hSvvOduPWiPqel2lvyMWCYTrkIjRfvl8Wv76hQciPpBvjeUFRn
 o15vjfbN1uxwoSaKGh/qFEZqz0jBCIOmoCK6AOlDyx48pe4JnowACtegmPXdCpYjN+jeZkdSsga
 7wWkLp48X4ciudQsY0aXERHmcbZwdeuEyxe3AcXM1Z76FIC7DBizSsoWJJtc0iSRIS9yhVAkwLX
 seNKXC05bcenkvIiYDV1/2t+zrBnTyGtdIwuqiV0ELJzkXhXyOok1qnBbmIuDcqCgsH6uS0994L
 FWkiwmFsMzLDxQY24Ah7Pykb
X-Received: by 2002:a05:6000:18a5:b0:3a4:f41d:696e with SMTP id
 ffacd0b85a97d-3a558a2774emr1640975f8f.27.1749628522573; 
 Wed, 11 Jun 2025 00:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHynn1ZmxEl0ZNtN7lwzF/YB68g1m/IIeKGN9HNrNlal1iZgAxPh0tTHdb6EJG0wWRJSEPxyg==
X-Received: by 2002:a05:6000:18a5:b0:3a4:f41d:696e with SMTP id
 ffacd0b85a97d-3a558a2774emr1640953f8f.27.1749628522197; 
 Wed, 11 Jun 2025 00:55:22 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de01sm14813526f8f.11.2025.06.11.00.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 00:55:21 -0700 (PDT)
Message-ID: <fc9689e4-f48c-4174-be02-9091338bfa1d@redhat.com>
Date: Wed, 11 Jun 2025 09:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rust/hw/char/pl011/src/device: Implement logging
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-3-shentey@gmail.com>
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
In-Reply-To: <20250610202110.2243-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/10/25 22:21, Bernhard Beschow wrote:
> Now that there is logging support in Rust for QEMU, use it in the pl011
> device.
Adding also this to match the C code:

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 42dfa9509dc..e505abfae86 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -305,6 +305,12 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
      }
  
      fn write_data_register(&mut self, value: u32) -> bool {
+        if !self.control.enable_uart() {
+            log_mask!(Log::GuestError, "PL011 data written to disabled UART\n");
+        }
+        if !self.control.enable_transmit() {
+            log_mask!(Log::GuestError, "PL011 data written to disabled TX UART\n");
+        }
          // interrupts always checked
          let _ = self.loopback_tx(value.into());
          self.int_level |= Interrupt::TX;



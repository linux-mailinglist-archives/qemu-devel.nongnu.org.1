Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B427D61BA
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:36:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXUL-0006gc-4J; Wed, 25 Oct 2023 02:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvXUD-0006eJ-G2
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvXUA-0003M3-SQ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698215721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=THnpO1jltEkUe0+XHN2M3L1CnQJSmQxbjXJrKUtUHEI=;
 b=YwVW/t1Wxkk8+hmC/7FEi7gBXqz+Qi44kDyLFkUOZmlrz7rQONnXNNrNLeJzkRozJ4SjIg
 5adGAhv/WCEiNOOlzN0zfayXV4fd7L/BRavZmbaPeSmrSaGUNGonnbGr0OBN4EQXNaFZFA
 CeMihyNs0JZHdvvP6XV+TUXCiboVEoQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-yy6kNqJUOi2O4U29zDALbQ-1; Wed, 25 Oct 2023 02:35:18 -0400
X-MC-Unique: yy6kNqJUOi2O4U29zDALbQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae57d8b502so323015266b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698215717; x=1698820517;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THnpO1jltEkUe0+XHN2M3L1CnQJSmQxbjXJrKUtUHEI=;
 b=fJDnlR1y9SRmZQBn1BWZcsFkBSmyXd4NdbUFfj9HMHzSea6t5C+nLj4XsV2FS+v7RG
 viI1hFpMQRvoAZZcxhOcF9W9vj0C24j6VrShlRjgeg1FcVAwb/HcdCkvrZxKS3Fkpyj/
 xB+9jXXrjhOpPhJ9Couq/2UOQ81YkeQVCfXlTTBHAIwrhSJjomas17ikl7Lvki9nB/UA
 0SM+Jmdzgz6vgo6zmevLAACP5RXkdHGRFsQwAr9xuwtDyJtbitlQCFynpNAwnC9FCF2L
 KgBCsE8F6rJ5rJHzSrrdYPYc4d+R0+h1Vo79AT3TK4JgaDdc5EHBr1DVzXBnS91MDN8l
 rmeQ==
X-Gm-Message-State: AOJu0YwpCTEpXGY0OPsu6V1860Co4567v/4TSRStfm8y2lKWr0FF08je
 rSBGQ+R30vQ0M5eGiqaprZeKPV6MTzWIh7iLh5jVlrCrEUNpinrlX73db/lOz1Ih9D5LI1UBNTU
 2YUB7+evwfFajTR8=
X-Received: by 2002:a17:907:724d:b0:9bd:b8d0:c099 with SMTP id
 ds13-20020a170907724d00b009bdb8d0c099mr9866706ejc.6.1698215717775; 
 Tue, 24 Oct 2023 23:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqjndOEBFRgUMB08uDJZ1ST3DDb07ngBvnPYZkJ7CLcDA30x6UmC1FNUYve4QAQEye7PrBcA==
X-Received: by 2002:a17:907:724d:b0:9bd:b8d0:c099 with SMTP id
 ds13-20020a170907724d00b009bdb8d0c099mr9866683ejc.6.1698215717472; 
 Tue, 24 Oct 2023 23:35:17 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-238.web.vodafone.de.
 [109.43.176.238]) by smtp.gmail.com with ESMTPSA id
 hv6-20020a17090760c600b00992f2befcbcsm9360510ejc.180.2023.10.24.23.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 23:35:16 -0700 (PDT)
Message-ID: <63a485f6-5a5a-46a6-9b19-4b32468a94cb@redhat.com>
Date: Wed, 25 Oct 2023 08:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/19] build-sys: add a "pixman" feature
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Gerd Hoffmann
 <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
 <20231023113047.2572137-2-marcandre.lureau@redhat.com>
Content-Language: en-US
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
In-Reply-To: <20231023113047.2572137-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/10/2023 13.30, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> For now, pixman is mandatory, but we set config_host.h and Kconfig.
> Once compilation is fixed, "pixman" will become actually optional.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   meson.build                   | 10 ++++++++--
>   include/ui/qemu-pixman.h      |  2 ++
>   Kconfig.host                  |  3 +++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   5 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 4961c82a6b..395d7155f6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -813,10 +813,14 @@ if 'ust' in get_option('trace_backends')
>                        method: 'pkg-config')
>   endif
>   pixman = not_found
> -if have_system or have_tools
> -  pixman = dependency('pixman-1', required: have_system, version:'>=0.21.8',
> +if not get_option('pixman').auto() or have_system or have_tools
> +  pixman = dependency('pixman-1', required: get_option('pixman'), version:'>=0.21.8',
>                         method: 'pkg-config')
>   endif
> +if not pixman.found() and (have_system or have_tools)
> +  error('FIXME: pixman is currently required')
> +endif
> +
>   zlib = dependency('zlib', required: true)
>   
>   libaio = not_found
> @@ -2125,6 +2129,7 @@ config_host_data.set('CONFIG_SECCOMP', seccomp.found())
>   if seccomp.found()
>     config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
>   endif
> +config_host_data.set('CONFIG_PIXMAN', pixman.found())
>   config_host_data.set('CONFIG_SNAPPY', snappy.found())
>   config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
>   if get_option('tcg').allowed()
> @@ -2843,6 +2848,7 @@ have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
>   host_kconfig = \
>     (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
>     (have_tpm ? ['CONFIG_TPM=y'] : []) + \
> +  (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
>     (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
>     (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
>     (opengl.found() ? ['CONFIG_OPENGL=y'] : []) + \
> diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> index e587c48b1f..d37feb5e3c 100644
> --- a/include/ui/qemu-pixman.h
> +++ b/include/ui/qemu-pixman.h
> @@ -6,11 +6,13 @@
>   #ifndef QEMU_PIXMAN_H
>   #define QEMU_PIXMAN_H
>   
> +#ifdef CONFIG_PIXMAN
>   /* pixman-0.16.0 headers have a redundant declaration */
>   #pragma GCC diagnostic push
>   #pragma GCC diagnostic ignored "-Wredundant-decls"
>   #include <pixman.h>
>   #pragma GCC diagnostic pop
> +#endif

Since we already require pixman 0.21, I wonder whether we still need these 
pragmas .... anyway, removing it would be something for another patch, so 
for this one:

Reviewed-by: Thomas Huth <thuth@redhat.com>




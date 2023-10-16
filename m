Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA9A7CA317
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:00:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJSb-0001yz-5u; Mon, 16 Oct 2023 05:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qsJSZ-0001yo-DV
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qsJSX-0003Ha-LF
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697446820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oyVVywQ5LwhrA2ZsJ40/4njDktclJKf/pSFvFq+HQAI=;
 b=UKlaN8ByikBI3qZ/zQXrzqXg1pGB63buIdbl7y76eKKCLW9osfJEIRMRFuHKDKNwkB2wL3
 XT9qODkVp+dEZrq5zHAmgtpDOHNn+Wqpg8gg95cOJC77Bh1FMdGwIC5NFGBIvEUJ+O4bN+
 SLU0KA25/lofYFJSdBkPVD5zEXu/naY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-pRotzYthOQWaTz1n1n6mSQ-1; Mon, 16 Oct 2023 05:00:17 -0400
X-MC-Unique: pRotzYthOQWaTz1n1n6mSQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4197d7e66ddso50149351cf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697446817; x=1698051617;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oyVVywQ5LwhrA2ZsJ40/4njDktclJKf/pSFvFq+HQAI=;
 b=R3MNj+67O/sEqSzO7E7sgEPF8533U2iDHiB9TTqe5lFMF2Lc/aUqu/dpbUfYjzaju/
 2yOWOytrEr+pVPwdrM2ydkO1pBvFQVniwrx1Dnrmk+398ujL7us0LstLIcSDbJrQLNzB
 6UV5VaqP8LxSRUrr5yPnx8prgaXlzY/kINZBbPLExmwxA/0PqRVRQC3EYvbIUrQ5EORQ
 flUQZolIy67xko+GhslwDfETiOMj6I58PRi5DaPqwfmM9u9bIm4ctO6NRkFmKNLSEUfn
 M3Ur/3C1/dBWBlghgG3gDK9BoSz3cr6KJOZ4acYLJ+SPRuTQmbypmXXBafO7VwXB7Vpv
 x3fg==
X-Gm-Message-State: AOJu0Yx2ETZGfXIILdKJfUmjIG4kYjmG8Lj9IHi6QOReah9AKXKJxyEA
 /Og7OUJlCJOiFyxY/o4bQDXCSf3RQP6nGTle+JHUsr6PDQlVkXg3MB0Z65H6ICpD5jOMa97Q1qe
 1KA9rqtfrDITyd6g=
X-Received: by 2002:a05:622a:58f:b0:410:ab6d:54da with SMTP id
 c15-20020a05622a058f00b00410ab6d54damr44639150qtb.16.1697446817403; 
 Mon, 16 Oct 2023 02:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy48HJe3T5TQ6RfUmcqJddC0+Riouu14WBK2XaVCGlqtdkAOFJVdnjrnTGEZNiZlPDEvizkA==
X-Received: by 2002:a05:622a:58f:b0:410:ab6d:54da with SMTP id
 c15-20020a05622a058f00b00410ab6d54damr44639132qtb.16.1697446817135; 
 Mon, 16 Oct 2023 02:00:17 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 y18-20020ac85252000000b00417dd1dd0adsm2868218qtn.87.2023.10.16.02.00.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:00:16 -0700 (PDT)
Message-ID: <cee1cc9f-ed36-4300-a712-d3fbef4bb395@redhat.com>
Date: Mon, 16 Oct 2023 11:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/vm: netbsd: install dtc
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231013153027.800327-1-pbonzini@redhat.com>
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
In-Reply-To: <20231013153027.800327-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 13/10/2023 17.30, Paolo Bonzini wrote:
> Install dtc as it is now a mandatory external dependency in order to build QEMU.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/vm/netbsd | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 939dc1b22a1..3ef1ec2d9cc 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -40,6 +40,9 @@ class NetBSDVM(basevm.BaseVM):
>           "gsed",
>           "gettext-tools",
>   
> +        # libs: basic
> +        "dtc",
> +
>           # libs: crypto
>           "gnutls",
>   

Does this work for you? When I run "make vm-build-netbsd", I'm still getting 
a failure:

76 packages to install:
   git-base-2.41.0nb1 pkgconf-1.9.5 xz-5.4.3 python310-3.10.12 
py310-expat-3.10.12nb1 ninja-build-1.11.1
   bash-5.2.15 gmake-4.4.1 gsed-4.9nb1 gettext-tools-0.21.1 dtc-1.7.0 
gnutls-3.8.0nb3 jpeg-9e png-1.6.39
   capstone-4.0.2 SDL2-2.26.5nb1 gtk3+-3.24.38 zstd-1.5.5 libslirp-4.7.0nb1 
pcre2-10.42 curl-8.1.2
   libuuid-2.32.1nb1 libffi-3.4.4 gettext-lib-0.21.1 p11-kit-0.24.1 nettle-3.9.1
   mozilla-rootcerts-1.0.20230505 libtasn1-4.19.0 libcfg+-0.7.0 gmp-6.2.1nb3 
wayland-protocols-1.31nb1
   wayland-1.21.0nb2 libxkbcommon-1.5.0nb1 libsamplerate-0.2.2nb4 
shared-mime-info-2.2nb2 pango-1.50.12nb1
   libcups-2.4.6nb1 libXft-2.3.8 hicolor-icon-theme-0.17nb1 glib2-2.74.6nb1 
gdk-pixbuf2-2.42.10nb2
   fribidi-1.0.13 freetype2-2.13.0nb1 fontconfig-2.14.2nb1 
cairo-gobject-1.16.0nb7 cairo-1.16.0nb9 atk-2.38.0
   at-spi2-atk-2.38.0nb1 lz4-1.9.4 nghttp2-1.54.0 libidn2-2.3.4 
readline-8.2nb2 libsndfile-1.2.0nb2
   fftw-3.3.10nb1 libxslt-1.1.38 libepoll-shim-0.0.20230411 
at-spi2-core-2.40.3nb2 lzo-2.10 brotli-1.0.9
   tiff-4.5.1nb1 libpaper-2.1.0nb2 dbus-1.14.6 harfbuzz-7.3.0 
graphite2-1.3.14nb1 libunistring-1.1
   libxml2-2.10.4nb1 libgcrypt-1.10.2 mpg123-1.31.3 libvorbis-1.3.7 
libopus-1.4 libogg-1.3.5nb1 lame-3.100nb5
   flac-1.4.2 jbigkit-2.1nb1 xmlcatmgr-2.2nb1 libgpg-error-1.47
[...]
installing dtc-1.7.0...
[...]
The Meson build system
Version: 0.63.3
Source dir: /home/qemu/qemu-test.Li0spd/src
Build dir: /home/qemu/qemu-test.Li0spd/build
Build type: native build
Project name: qemu
Project version: 8.1.50
C compiler for the host machine: cc -m64 -mcx16 (gcc 7.5.0 "cc (nb4 
20200810) 7.5.0")
C linker for the host machine: cc -m64 -mcx16 ld.bfd 2.31.1
[...]
Run-time dependency capstone found: YES 4.0.2
Library fdt found: NO
Initialized empty Git repository in 
/home/qemu/qemu-test.Li0spd/src/subprojects/dtc/.git/
fatal: unable to access 'https://gitlab.com/qemu-project/dtc.git/': SSL 
certificate problem: unable to get local issuer certificate

../src/meson.build:3076:4: ERROR: Git command failed: ['/usr/pkg/bin/git', 
'fetch', '--depth', '1', 'origin', 'b6910bec11614980a21e46fbccc35934b671bd81']

A full log can be found at 
/home/qemu/qemu-test.Li0spd/build/meson-logs/meson-log.txt

ERROR: meson setup failed

... so though the NetBSD people finally upgraded their dtc to a usable 
level, our meson.build seems to be unable to detect it?

  Thomas




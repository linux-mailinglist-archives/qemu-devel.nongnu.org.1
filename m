Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5CE94F1E1
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Aug 2024 17:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdX8K-0002Ma-Kc; Mon, 12 Aug 2024 11:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdX8I-0002LQ-7o
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdX8F-000257-4L
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723477128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tW1gNuz13O7qaRiLAV2/+sEuFPyCxcMeK74iH9jpeHE=;
 b=WaiF/6tANdlSswiXhDXI9sfMzzicu3/nYA+CPUbIipodoqg6aLxTE7DghiuJw2YmXw8yNt
 +Ah0s8mHCLjeHuu9Vc2rPkLwf1kN1F8jsiBL3kzn4Ne5junfYuykpSoz2jjCbiIWq3/uLq
 7LGd8tb2wLMog03yfdQHpVj0lFUZ3aw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Eto2cKaBOyqD9tgZRGBEEA-1; Mon, 12 Aug 2024 11:38:45 -0400
X-MC-Unique: Eto2cKaBOyqD9tgZRGBEEA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427b7a2052bso52676535e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 08:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723477124; x=1724081924;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tW1gNuz13O7qaRiLAV2/+sEuFPyCxcMeK74iH9jpeHE=;
 b=kWJReR1I7/QcpfCkYcS7hBAzKH7QY8NRKPcpyTksi8BOFeoP5ZQmzJua1PV57NdL7B
 N0BxYZMrewWdDpn8RyYrJ2JHNEsktNxP4dasNk5AFcHFRIwSKpqhCk3GponEEY4mrvXl
 HLa91tXIUD2Ye6ArGtNL5zSxtGpUct20WAZMmlZYKz9YTznLcGfL3oDEOKmK9j1TDla5
 rRhvgVXeCibD40AIqCtRfevGz2Ey9gk9BzVYqWnTf0+G/KtBo1kO7nJixgKfm++YOlce
 UGn03bZk+Ph/wn7Eesr9ksIxD0phQQJK1XIgEPhn5OKcyaBmhp5Bi9uNaJscq6BKfKFm
 Rasw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT7cbgd3q9Qdzzel0q5veXVJuRuFhS3jyooQEFY0tMlQsXCssUWvDM4qHWAdRqadu/GMwV9B7dc+fn0JYtatvuFCOaoNE=
X-Gm-Message-State: AOJu0YxZi8MzWr82lzCiCaNrJWvxX8bpF1PKggOevD0P51qDg008QbpS
 Pni1mbsdKEefdDGjAfLNQpWiz1QKeLU/+QRjVV0DUe5iUh+C6Z/z+TGeundDE2DD6baabywre0+
 yEIqYdNSrtHv3e/BJNSV4/Lyzn/ZkPxMe1bVpAxYXZN6P1UXA8siS
X-Received: by 2002:a05:6000:10c5:b0:368:7868:2d76 with SMTP id
 ffacd0b85a97d-3716cd24e73mr673148f8f.51.1723477123895; 
 Mon, 12 Aug 2024 08:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDlt6R+yQRpP3eCmsbSrOb00USULK+qPi45scSeuLbVRIe1FBbMSNT7qyvNqPMngpgttz/JQ==
X-Received: by 2002:a05:6000:10c5:b0:368:7868:2d76 with SMTP id
 ffacd0b85a97d-3716cd24e73mr673114f8f.51.1723477123270; 
 Mon, 12 Aug 2024 08:38:43 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-125.web.vodafone.de.
 [109.43.178.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c9288af4sm88940615e9.0.2024.08.12.08.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 08:38:42 -0700 (PDT)
Message-ID: <25ea7357-99e1-4fdf-9ef8-885cb7e75f47@redhat.com>
Date: Mon, 12 Aug 2024 17:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/11] crypto: push error reporting into TLS session I/O
 APIs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20240724094706.30396-1-berrange@redhat.com>
 <20240724094706.30396-11-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
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
In-Reply-To: <20240724094706.30396-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 24/07/2024 11.47, Daniel P. Berrangé wrote:
> The current TLS session I/O APIs just return a synthetic errno
> value on error, which has been translated from a gnutls error
> value. This looses a large amount of valuable information that
> distinguishes different scenarios.
> 
> Pushing population of the "Error *errp" object into the TLS
> session I/O APIs gives more detailed error information.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

  Hi Daniel!

iotest 233 is failing for me with -raw now, and bisection
points to this commit. Output is:

--- .../qemu/tests/qemu-iotests/233.out
+++ /tmp/qemu/tests/qemu-iotests/scratch/raw-file-233/233.out.bad
@@ -69,8 +69,8 @@
  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

  == check TLS with authorization ==
-qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort
-qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort
+qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: The TLS connection was non-properly terminated.
+qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: The TLS connection was non-properly terminated.

  == check TLS fail over UNIX with no hostname ==
  qemu-img: Could not open 'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0': No hostname for certificate validation
@@ -103,14 +103,14 @@
  qemu-nbd: TLS handshake failed: The TLS connection was non-properly terminated.

  == final server log ==
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: The TLS connection was non-properly terminated.
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: The TLS connection was non-properly terminated.
  qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
  qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
  qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
  qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: The TLS connection was non-properly terminated.
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: The TLS connection was non-properly terminated.
  qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
  qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
  *** done

Could you please have a look?

  Thanks,
   Thomas

> 
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index 1e98f44e0d..926f19c115 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -441,23 +441,20 @@ qcrypto_tls_session_set_callbacks(QCryptoTLSSession *session,
>   ssize_t
>   qcrypto_tls_session_write(QCryptoTLSSession *session,
>                             const char *buf,
> -                          size_t len)
> +                          size_t len,
> +                          Error **errp)
>   {
>       ssize_t ret = gnutls_record_send(session->handle, buf, len);
>   
>       if (ret < 0) {
> -        switch (ret) {
> -        case GNUTLS_E_AGAIN:
> -            errno = EAGAIN;
> -            break;
> -        case GNUTLS_E_INTERRUPTED:
> -            errno = EINTR;
> -            break;
> -        default:
> -            errno = EIO;
> -            break;
> +        if (ret == GNUTLS_E_AGAIN) {
> +            return QCRYPTO_TLS_SESSION_ERR_BLOCK;
> +        } else {
> +            error_setg(errp,
> +                       "Cannot write to TLS channel: %s",
> +                       gnutls_strerror(ret));
> +            return -1;
>           }
> -        ret = -1;
>       }
>   
>       return ret;
> @@ -467,26 +464,24 @@ qcrypto_tls_session_write(QCryptoTLSSession *session,
>   ssize_t
>   qcrypto_tls_session_read(QCryptoTLSSession *session,
>                            char *buf,
> -                         size_t len)
> +                         size_t len,
> +                         bool gracefulTermination,
> +                         Error **errp)
>   {
>       ssize_t ret = gnutls_record_recv(session->handle, buf, len);
>   
>       if (ret < 0) {
> -        switch (ret) {
> -        case GNUTLS_E_AGAIN:
> -            errno = EAGAIN;
> -            break;
> -        case GNUTLS_E_INTERRUPTED:
> -            errno = EINTR;
> -            break;
> -        case GNUTLS_E_PREMATURE_TERMINATION:
> -            errno = ECONNABORTED;
> -            break;
> -        default:
> -            errno = EIO;
> -            break;
> +        if (ret == GNUTLS_E_AGAIN) {
> +            return QCRYPTO_TLS_SESSION_ERR_BLOCK;
> +        } else if ((ret == GNUTLS_E_PREMATURE_TERMINATION) &&
> +                   gracefulTermination){
> +            return 0;
> +        } else {
> +            error_setg(errp,
> +                       "Cannot read from TLS channel: %s",
> +                       gnutls_strerror(ret));
> +            return -1;
>           }
> -        ret = -1;
>       }
>   
>       return ret;
> @@ -605,9 +600,10 @@ qcrypto_tls_session_set_callbacks(
>   ssize_t
>   qcrypto_tls_session_write(QCryptoTLSSession *sess,
>                             const char *buf,
> -                          size_t len)
> +                          size_t len,
> +                          Error **errp)
>   {
> -    errno = -EIO;
> +    error_setg(errp, "TLS requires GNUTLS support");
>       return -1;
>   }
>   
> @@ -615,9 +611,11 @@ qcrypto_tls_session_write(QCryptoTLSSession *sess,
>   ssize_t
>   qcrypto_tls_session_read(QCryptoTLSSession *sess,
>                            char *buf,
> -                         size_t len)
> +                         size_t len,
> +                         bool gracefulTermination,
> +                         Error **errp)
>   {
> -    errno = -EIO;
> +    error_setg(errp, "TLS requires GNUTLS support");
>       return -1;
>   }
>   
> diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
> index 571049bd0e..291e602540 100644
> --- a/include/crypto/tlssession.h
> +++ b/include/crypto/tlssession.h
> @@ -107,6 +107,7 @@
>   
>   typedef struct QCryptoTLSSession QCryptoTLSSession;
>   
> +#define QCRYPTO_TLS_SESSION_ERR_BLOCK -2
>   
>   /**
>    * qcrypto_tls_session_new:
> @@ -212,6 +213,7 @@ void qcrypto_tls_session_set_callbacks(QCryptoTLSSession *sess,
>    * @sess: the TLS session object
>    * @buf: the plain text to send
>    * @len: the length of @buf
> + * @errp: pointer to hold returned error object
>    *
>    * Encrypt @len bytes of the data in @buf and send
>    * it to the remote peer using the callback previously
> @@ -221,32 +223,45 @@ void qcrypto_tls_session_set_callbacks(QCryptoTLSSession *sess,
>    * qcrypto_tls_session_get_handshake_status() returns
>    * QCRYPTO_TLS_HANDSHAKE_COMPLETE
>    *
> - * Returns: the number of bytes sent, or -1 on error
> + * Returns: the number of bytes sent,
> + * or QCRYPTO_TLS_SESSION_ERR_BLOCK if the write would block,
> + * or -1 on error.
>    */
>   ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
>                                     const char *buf,
> -                                  size_t len);
> +                                  size_t len,
> +                                  Error **errp);
>   
>   /**
>    * qcrypto_tls_session_read:
>    * @sess: the TLS session object
>    * @buf: to fill with plain text received
>    * @len: the length of @buf
> + * @gracefulTermination: treat premature termination as graceful EOF
> + * @errp: pointer to hold returned error object
>    *
>    * Receive up to @len bytes of data from the remote peer
>    * using the callback previously registered with
>    * qcrypto_tls_session_set_callbacks(), decrypt it and
>    * store it in @buf.
>    *
> + * If @gracefulTermination is true, then a premature termination
> + * of the TLS session will be treated as indicating EOF, as
> + * opposed to an error.
> + *
>    * It is an error to call this before
>    * qcrypto_tls_session_get_handshake_status() returns
>    * QCRYPTO_TLS_HANDSHAKE_COMPLETE
>    *
> - * Returns: the number of bytes received, or -1 on error
> + * Returns: the number of bytes received,
> + * or QCRYPTO_TLS_SESSION_ERR_BLOCK if the receive would block,
> + * or -1 on error.
>    */
>   ssize_t qcrypto_tls_session_read(QCryptoTLSSession *sess,
>                                    char *buf,
> -                                 size_t len);
> +                                 size_t len,
> +                                 bool gracefulTermination,
> +                                 Error **errp);
>   
>   /**
>    * qcrypto_tls_session_check_pending:
> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index 67b9700006..9d8bb158d1 100644
> --- a/io/channel-tls.c
> +++ b/io/channel-tls.c
> @@ -277,24 +277,19 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
>       ssize_t got = 0;
>   
>       for (i = 0 ; i < niov ; i++) {
> -        ssize_t ret = qcrypto_tls_session_read(tioc->session,
> -                                               iov[i].iov_base,
> -                                               iov[i].iov_len);
> -        if (ret < 0) {
> -            if (errno == EAGAIN) {
> -                if (got) {
> -                    return got;
> -                } else {
> -                    return QIO_CHANNEL_ERR_BLOCK;
> -                }
> -            } else if (errno == ECONNABORTED &&
> -                       (qatomic_load_acquire(&tioc->shutdown) &
> -                        QIO_CHANNEL_SHUTDOWN_READ)) {
> -                return 0;
> +        ssize_t ret = qcrypto_tls_session_read(
> +            tioc->session,
> +            iov[i].iov_base,
> +            iov[i].iov_len,
> +            qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
> +            errp);
> +        if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
> +            if (got) {
> +                return got;
> +            } else {
> +                return QIO_CHANNEL_ERR_BLOCK;
>               }
> -
> -            error_setg_errno(errp, errno,
> -                             "Cannot read from TLS channel");
> +        } else if (ret < 0) {
>               return -1;
>           }
>           got += ret;
> @@ -321,18 +316,15 @@ static ssize_t qio_channel_tls_writev(QIOChannel *ioc,
>       for (i = 0 ; i < niov ; i++) {
>           ssize_t ret = qcrypto_tls_session_write(tioc->session,
>                                                   iov[i].iov_base,
> -                                                iov[i].iov_len);
> -        if (ret <= 0) {
> -            if (errno == EAGAIN) {
> -                if (done) {
> -                    return done;
> -                } else {
> -                    return QIO_CHANNEL_ERR_BLOCK;
> -                }
> +                                                iov[i].iov_len,
> +                                                errp);
> +        if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
> +            if (done) {
> +                return done;
> +            } else {
> +                return QIO_CHANNEL_ERR_BLOCK;
>               }
> -
> -            error_setg_errno(errp, errno,
> -                             "Cannot write to TLS channel");
> +        } else if (ret < 0) {
>               return -1;
>           }
>           done += ret;



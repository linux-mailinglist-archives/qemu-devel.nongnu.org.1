Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76081AF56
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 08:23:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGDOy-0004dJ-RC; Thu, 21 Dec 2023 02:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGDOv-0004W3-Hc
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGDOt-0001t5-Hh
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703143400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W+pMYUns55+OPs2OpYe1aisPNcMf1NnP2CvsISUW1tw=;
 b=h8SwDaPKJjMlvv3NpoULKYUFJo1dzMfuf0jFjFWm56IEE0Figy38hpQNRmpG1C6GtE4P2T
 5BopubhDGZh/+qd/hErgYZmWNwX4N10QD/CKXWkL7G6UFy/ehCc4AjJewmhCHcpOC1Cakq
 dsiIoh6KVBlDelvnE8L+8/LA+8xEwCI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-apxELONIM2SYsyJxMv5u5Q-1; Thu, 21 Dec 2023 02:23:19 -0500
X-MC-Unique: apxELONIM2SYsyJxMv5u5Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d39bbe215so3441685e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 23:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703143398; x=1703748198;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+pMYUns55+OPs2OpYe1aisPNcMf1NnP2CvsISUW1tw=;
 b=Gz48RsRQkLZacX1zcbJJQbyBejXD+pQGFZAZP6vvX++ilOcJBWMbIsvqz16bW+2Ic9
 q+TQ+e85Nh5rycyyYAD8weT1j87yXV/QvlPOKMmbhdK9JXge0n1eWqz3r5YMvdptQ44Q
 wz2INd60UgMMbJYF5PlB+gnU6tsX6bhMfrHqtWSN0b0UkgtEU0XPLnYlHxtZE3w2YEG8
 ArtvbQ/iRx4SAldBnNwHZ8dxlCCSWnnuNoM4KuOjodcuJPucBVzHnqQUOvDhmvmGCkc6
 QkFu9Ik5FE9dYZvfUR6iVV4rI7TXxegI5Xp/+56Ol83xqLKMz/YU5R2A5y9cIB1x6zWE
 UYJw==
X-Gm-Message-State: AOJu0YzLXnFWOYVhzVowg/bEbTCz7knupK12pXENmK9i/Dzx/W7lCLI8
 SHpsrwJRjQaO8cqSqmQfRdXas1FZk30e2Vp0k0CmOpbtKOLGvPS2L3pqWiCV627cliyC8bjrx6K
 w0GthECZDJILjM+U=
X-Received: by 2002:a1c:7712:0:b0:40d:3d60:4696 with SMTP id
 t18-20020a1c7712000000b0040d3d604696mr275182wmi.48.1703143398060; 
 Wed, 20 Dec 2023 23:23:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXDvyYhUceDqILUA0MElAaewU86T3/RZfYrURxrnjuCO2Yn/fWuD81pRXLIsJIMUq6oeAMsg==
X-Received: by 2002:a1c:7712:0:b0:40d:3d60:4696 with SMTP id
 t18-20020a1c7712000000b0040d3d604696mr275170wmi.48.1703143397698; 
 Wed, 20 Dec 2023 23:23:17 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 e9-20020a05600c4e4900b0040d3bda78basm1837911wmq.26.2023.12.20.23.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 23:23:17 -0800 (PST)
Message-ID: <8ff9a950-4075-4c86-bf5d-df8b90eb450a@redhat.com>
Date: Thu, 21 Dec 2023 08:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] nbd/server: only traverse NBDExport->clients from
 main loop thread
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20231221014903.1537962-1-stefanha@redhat.com>
 <20231221014903.1537962-6-stefanha@redhat.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
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
In-Reply-To: <20231221014903.1537962-6-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

On 12/21/23 02:49, Stefan Hajnoczi wrote:
> The NBD clients list is currently accessed from both the export
> AioContext and the main loop thread. When the AioContext lock is removed
> there will be nothing protecting the clients list.
> 
> Adding a lock around the clients list is tricky because NBDClient
> structs are refcounted and may be freed from the export AioContext or
> the main loop thread. nbd_export_request_shutdown() -> client_close() ->
> nbd_client_put() is also tricky because the list lock would be held
> while indirectly dropping references to NDBClients.
> 
> A simpler approach is to only allow nbd_client_put() and client_close()
> calls from the main loop thread. Then the NBD clients list is only
> accessed from the main loop thread and no fancy locking is needed.
> 
> nbd_trip() just needs to reschedule itself in the main loop AioContext
> before calling nbd_client_put() and client_close(). This costs more CPU
> cycles per NBD request but is needed for thread-safety when the
> AioContext lock is removed.
> 
> Note that nbd_client_get() can still be called from either thread, so
> make NBDClient->refcount atomic.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   nbd/server.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 0b09ccc8dc..527fbdab4a 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -122,7 +122,7 @@ struct NBDMetaContexts {
>   };
>   
>   struct NBDClient {
> -    int refcount;
> +    int refcount; /* atomic */
>       void (*close_fn)(NBDClient *client, bool negotiated);
>   
>       NBDExport *exp;
> @@ -1501,14 +1501,17 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
>   
>   #define MAX_NBD_REQUESTS 16
>   
> +/* Runs in export AioContext and main loop thread */
>   void nbd_client_get(NBDClient *client)
>   {
> -    client->refcount++;
> +    qatomic_inc(&client->refcount);
>   }
>   
>   void nbd_client_put(NBDClient *client)
>   {
> -    if (--client->refcount == 0) {
> +    assert(qemu_in_main_thread());
> +
> +    if (qatomic_fetch_dec(&client->refcount) == 1) {
>           /* The last reference should be dropped by client->close,
>            * which is called by client_close.
>            */
> @@ -1531,6 +1534,8 @@ void nbd_client_put(NBDClient *client)
>   
>   static void client_close(NBDClient *client, bool negotiated)
>   {
> +    assert(qemu_in_main_thread());
> +
>       if (client->closing) {
>           return;
>       }
> @@ -2938,8 +2943,15 @@ static coroutine_fn void nbd_trip(void *opaque)
>       int ret;
>       Error *local_err = NULL;
>   
> +    /*
> +     * Note that nbd_client_put() and client_close() must be called from the
> +     * main loop thread. Use aio_co_reschedule_self() to switch AioContext
> +     * before calling these functions.
> +     */
> +
>       trace_nbd_trip();
>       if (client->closing) {
> +        aio_co_reschedule_self(qemu_get_aio_context());
>           nbd_client_put(client);
>           return;
>       }
> @@ -2949,6 +2961,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>            * We're switching between AIO contexts. Don't attempt to receive a new
>            * request and kick the main context which may be waiting for us.
>            */
> +        aio_co_reschedule_self(qemu_get_aio_context());
>           nbd_client_put(client);
>           client->recv_coroutine = NULL;
>           aio_wait_kick();
> @@ -3013,6 +3026,8 @@ static coroutine_fn void nbd_trip(void *opaque)
>       qio_channel_set_cork(client->ioc, false);
>   done:
>       nbd_request_put(req);
> +
> +    aio_co_reschedule_self(qemu_get_aio_context());
>       nbd_client_put(client);
>       return;

This is very expensive to do on every NBD receive, considering that it really
can happen only when closing (see the assertion in nbd_client_put).

In Linux there is a common pattern of "if refcount could go to zero, take
a lock before doing the decrement".  We can do something similar with "if
refcount could go to zero, move to main iothread before doing the decrement":

diff --git a/nbd/server.c b/nbd/server.c
index 895cf0a7525..aec306923d8 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1529,6 +1529,21 @@ void nbd_client_put(NBDClient *client)
      }
  }
  
+static bool nbd_client_put_nonzero(NBDClient *client)
+{
+    int old = qatomic_read(&client->refcount);
+    do {
+        if (old == 1) {
+            return false;
+        }
+
+        int expected = old;
+        old = qatomic_cmpxchg(&client->refcount, expected, expected - 1);
+    } while (old != expected);
+
+    return true;
+}
+
  static void client_close(NBDClient *client, bool negotiated)
  {
      if (client->closing) {
@@ -2936,15 +2951,14 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
  static coroutine_fn void nbd_trip(void *opaque)
  {
      NBDClient *client = opaque;
-    NBDRequestData *req;
+    NBDRequestData *req = NULL;
      NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
      int ret;
      Error *local_err = NULL;
  
      trace_nbd_trip();
      if (client->closing) {
-        nbd_client_put(client);
-        return;
+        goto done;
      }
  
      if (client->quiescing) {
@@ -2952,10 +2966,9 @@ static coroutine_fn void nbd_trip(void *opaque)
           * We're switching between AIO contexts. Don't attempt to receive a new
           * request and kick the main context which may be waiting for us.
           */
-        nbd_client_put(client);
          client->recv_coroutine = NULL;
          aio_wait_kick();
-        return;
+        goto done;
      }
  
      req = nbd_request_get(client);
@@ -3015,8 +3028,13 @@ static coroutine_fn void nbd_trip(void *opaque)
  
      qio_channel_set_cork(client->ioc, false);
  done:
-    nbd_request_put(req);
-    nbd_client_put(client);
+    if (req) {
+        nbd_request_put(req);
+    }
+    if (!nbd_client_put_nonzero(client)) {
+        aio_co_reschedule_self(qemu_get_aio_context());
+        nbd_client_put(client);
+    }
      return;
  
  disconnect:

I think adding the "if (req)" should also simplify a little bit the addition of the lock.

Paolo



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E87BB2A2
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 09:49:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofZR-00036h-OV; Fri, 06 Oct 2023 03:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qofZO-00036N-QL
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qofZN-0006kf-2I
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696578499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L78QiQ7U8iEcVw6ytSzFgl9vpU4+LmwhoXn5L51h0tE=;
 b=GRmrxWlxg5cM6Mv1Pkvn74RDO9uI3QLzjJ7Ow6CEeiC8PC+ZFafUsamrbAlh6wLPwp/TeB
 MjrwgeEx3hEwD4v1BMP25F1tVnPIM/fAFAzh9ylGmZ9g7Sy2NapPYH3tIEHJHMgF8xJuVT
 5gmy+NPOeKgkaP3Db3QF3FAGvWYBALw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-VaORRc8AORy-D6rLySLD1Q-1; Fri, 06 Oct 2023 03:48:17 -0400
X-MC-Unique: VaORRc8AORy-D6rLySLD1Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b98bbf130cso153551166b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 00:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696578496; x=1697183296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L78QiQ7U8iEcVw6ytSzFgl9vpU4+LmwhoXn5L51h0tE=;
 b=R2TKFsOmNl9Gl9WekKeqxsVHZQlC9iWUbVRy2Akz8Jgk3jUe+EpYEo6EK7gugC+u60
 4qsyQF1XeI8zV1Df3Z+81lRom7MxXx2o8zS1ZbjFEXJHnwhLh/QKbHy7shozLJu/glfk
 wJj9+1LuNbqQIppx0T47zb2yj1jwky1sP6Lsh2J8S4U5O3LplpsbtuYfK9yNuV8PJ3lT
 YQvTKtGTxOuynuAMLsrzOhqdBM0Mbq09S7Lm8+6BtQr7GzvTEoDdx/zsDUTdxkAyVAIQ
 sG5tHjY1vby+qrBIQxT8QDt4eN/kaaxV+AePMrMcEwXnJv1EeqlQjitq7xKJAbqmFfkd
 fGDg==
X-Gm-Message-State: AOJu0YzEd4K20ZtW7eigxMb1nF/xdctTVmSsHMkbwcRaAQnmckQ6d2Ow
 vlX9n4bYXkCJCvJFRXrPt6jBA+E+5M0JqW/2LP7QsRa09P0wfTBSWYUzDeKgxEa4ikVFfUew6NU
 XQKivoCpiXJjazQ8=
X-Received: by 2002:a17:906:cc13:b0:9ae:63bd:a7fe with SMTP id
 ml19-20020a170906cc1300b009ae63bda7femr6177697ejb.10.1696578496577; 
 Fri, 06 Oct 2023 00:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcixacUokCdL9AvzNlPwh+be/y6pVOMGbgdSDaFiBFWFBeQHqIQpxIU5kZmnSqxFmcZyRLxg==
X-Received: by 2002:a17:906:cc13:b0:9ae:63bd:a7fe with SMTP id
 ml19-20020a170906cc1300b009ae63bda7femr6177680ejb.10.1696578496233; 
 Fri, 06 Oct 2023 00:48:16 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 dx12-20020a170906a84c00b009b977bea1dcsm2427925ejb.23.2023.10.06.00.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 00:48:15 -0700 (PDT)
Message-ID: <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
Date: Fri, 6 Oct 2023 09:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231005131352-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 05.10.23 19:15, Michael S. Tsirkin wrote:
> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
>>> There is no clearly defined purpose for the virtio status byte in
>>> vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
>>> feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
>>> protocol extension, it is possible for SET_FEATURES to return errors
>>> (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
>>>
>>> As for implementations, SET_STATUS is not widely implemented.  dpdk does
>>> implement it, but only uses it to signal feature negotiation failure.
>>> While it does log reset requests (SET_STATUS 0) as such, it effectively
>>> ignores them, in contrast to RESET_OWNER (which is deprecated, and today
>>> means the same thing as RESET_DEVICE).
>>>
>>> While qemu superficially has support for [GS]ET_STATUS, it does not
>>> forward the guest-set status byte, but instead just makes it up
>>> internally, and actually completely ignores what the back-end returns,
>>> only using it as the template for a subsequent SET_STATUS to add single
>>> bits to it.  Notably, after setting FEATURES_OK, it never reads it back
>>> to see whether the flag is still set, which is the only way in which
>>> dpdk uses the status byte.
>>>
>>> As-is, no front-end or back-end can rely on the other side handling this
>>> field in a useful manner, and it also provides no practical use over
>>> other mechanisms the vhost-user protocol has, which are more clearly
>>> defined.  Deprecate it.
>>>
>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>> ---
>>>   docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
>>>   1 file changed, 21 insertions(+), 7 deletions(-)
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> SET_STATUS is the only way to signal failure to acknowledge FEATURES_OK.
> The fact current backends never check errors does not mean they never
> will. So no, not applying this.

Can this not be done with REPLY_ACK?  I.e., with the following message 
order:

1. GET_FEATURES to find out whether VHOST_USER_F_PROTOCOL_FEATURES is 
present
2. GET_PROTOCOL_FEATURES to hopefully get VHOST_USER_PROTOCOL_F_REPLY_ACK
3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
4. SET_FEATURES with need_reply

If not, the problem is that qemu has sent SET_STATUS 0 for a while when 
the vCPUs are stopped, which generally seems to request a device reset.  
If we don’t state at least that SET_STATUS 0 is to be ignored, back-ends 
that will implement SET_STATUS later may break with at least these qemu 
versions.  But documenting that a particular use of the status byte is 
to be ignored would be really strange.

Hanna



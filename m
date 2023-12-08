Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1680A3F9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 13:55:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBaMU-0008Ic-Vc; Fri, 08 Dec 2023 07:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rBaMT-0008I2-5h
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 07:53:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rBaMR-0004zL-OU
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 07:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702040021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6G0OL2BJgOrKj5CWSn1mbBD4f1PotPBOucH5A6jfylc=;
 b=h95F4uPRCtqVT5orzoBKdURIK1Cj/q1JVBgF3AGXNSyUL29N5W1vM//Idhc1b8mwRhs4+x
 KEPA18c/g/0lynlTXST25wfCDfG3bIIIaSbzbT0QQFZwl5nkb1CHuH4N+ImMYgkHcG2ulx
 mCZEJ0lcy2hdhVPmHyn0Q3A8jdiL7eA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-_2AngrqqO5masZLOtE9lxA-1; Fri,
 08 Dec 2023 07:53:38 -0500
X-MC-Unique: _2AngrqqO5masZLOtE9lxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9C0B3C02B81;
 Fri,  8 Dec 2023 12:53:37 +0000 (UTC)
Received: from [10.39.193.124] (unknown [10.39.193.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8F8E3C2E;
 Fri,  8 Dec 2023 12:53:35 +0000 (UTC)
Message-ID: <d8e3e9de-3fdd-6b61-a775-e020aa4df1f7@redhat.com>
Date: Fri, 8 Dec 2023 13:53:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 05/16] hw/uefi: add var-service-core.c
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Blake
 <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 graf@amazon.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20231115151242.184645-1-kraxel@redhat.com>
 <20231115151242.184645-6-kraxel@redhat.com>
 <f3794048-d8b9-7f53-d191-3ffbe75cee82@redhat.com>
 <asxz5xxm5yjrwamdpqglseayy6q2uy24gpwf6pp26ged2ynt7k@g3nvpumuen5c>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <asxz5xxm5yjrwamdpqglseayy6q2uy24gpwf6pp26ged2ynt7k@g3nvpumuen5c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 11/22/23 17:30, Gerd Hoffmann wrote:
>   Hi,
> 
>> - in general, we should filter out surrogate code points, for any use.
>> any UCS2 string from the guest that contains a surrogate code point
>> should be considered invalid, and the request should be rejected based
>> just on that.
> 
> Something like this?

yes please (except I'd recommend s/outlaw/reject/ in the comment)

Thanks
laszlo

> 
> edk2 seems to be inconsistent with strings, sometimes they are expected
> to include a terminating '\0' char (most of the time), sometimes not
> (in variable policies for example).
> 
> gboolean uefi_str_is_valid(const uint16_t *str, size_t len,
>                            gboolean must_be_null_terminated)
> {
>     size_t pos = 0;
> 
>     for (;;) {
>         if (pos == len) {
>             if (must_be_null_terminated) {
>                 return false;
>             } else {
>                 return true;
>             }
>         }
>         switch (str[pos]) {
>         case 0:
>             /* end of string */
>             return true;
>             ;;
>         case 0xd800 ... 0xdfff:
>             /* outlaw surrogates */
>             return false;
>         default:
>             /* char is good, check next */
>             break;
>         }
>         pos++;
>     }
> }
> 
> take care,
>   Gerd
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 208909BB9BF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Nov 2024 17:03:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zY3-0007uZ-Qo; Mon, 04 Nov 2024 11:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t7zY2-0007u9-3g
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t7zY0-0007C0-7d
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730736199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7JZC3v6eydwHk6rZe8ncBZSlWNsGSCPyYUdAuTRxSck=;
 b=SecQ3SANRW6m7UJuuKibG2Urfkj+8VQ4UL4rcQUw0O7dUkjkhdvCumWZrNqhVunc2Dfq40
 U2nbxiwYrN096YcUhgMxtnjrsX8c/1LNupFwbz+LbBVr5XFqQkRklpRA0L8be1tpbT5q+x
 uo5GDMnxn5JsJfOX6PRLVh2zgYi6vI4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-7J6MbSZnPsWMJYkVUFj-iw-1; Mon, 04 Nov 2024 11:03:16 -0500
X-MC-Unique: 7J6MbSZnPsWMJYkVUFj-iw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d67f4bf98so1960377f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730736195; x=1731340995;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7JZC3v6eydwHk6rZe8ncBZSlWNsGSCPyYUdAuTRxSck=;
 b=NeYAmZ70qwvqjr6YjjrShKm2jrAmYVpPWrWKJ2fcTDj72GIP6GMIjvq+QEbDPmUBaR
 J5qH4n12ONlszJYFQqpth7xAZAy5kB4baHxRzyD8wrtrps/uaInRD60tPUj1yV7g3A4R
 nf2hPUqZDtutFmX0U4qdvkj3c8woaCJf+MZimwDMoi2m0JIsDnLYiJ8VpAcugzwW2nEX
 YMDeUJwKFzoRR52M91VhgPdnTRNADItEz3rYPuiBr2ZURhFqD4GjrRsoNPv3FX1n2vk0
 TvNYDYt2qsQKGIjG4hfFqOTIicEi/yMGPNW5ypSp2KDPMsTJPEw/ZNSn2ONtR662PoA0
 Y3NQ==
X-Gm-Message-State: AOJu0YwjVZHK+sPU+uJT8wYE7GmPJLQZxydfm1g6SDtGcBcLjmMl9+c9
 7I2X4Sga4fSH3OCGLF/Desh0JXgyw2sFwITQjcY7PQJTpSRC3nrqkzv0XWTEFRlREV7ApKWiuzH
 8mwsUY9UIIT4m1N0hzhEqEOkAMfeMLbKqkXClbz/mPCqiU23vsupf
X-Received: by 2002:a5d:5711:0:b0:37c:ccad:733a with SMTP id
 ffacd0b85a97d-38061219b44mr19847573f8f.59.1730736195053; 
 Mon, 04 Nov 2024 08:03:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEO6Paty3JJXjJI8yUnowCyn+GF+kPK7yGWvQUBMOPlzdD2i0CWR5lASleHjnZHFjqisS1u7w==
X-Received: by 2002:a5d:5711:0:b0:37c:ccad:733a with SMTP id
 ffacd0b85a97d-38061219b44mr19847538f8f.59.1730736194488; 
 Mon, 04 Nov 2024 08:03:14 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381c113e69fsm13551800f8f.69.2024.11.04.08.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 08:03:13 -0800 (PST)
Message-ID: <f13766c1-12e2-46b2-a139-c926824c50e0@redhat.com>
Date: Mon, 4 Nov 2024 17:03:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/23] rust: introduce alternative implementation of
 offset_of!
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 zhao1.liu@intel.com, berrange@redhat.com
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-16-pbonzini@redhat.com>
 <SY0P300MB1026D525F3022164941671B895502@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <SY0P300MB1026D525F3022164941671B895502@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/3/24 10:54, Junjie Mao wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> From: Junjie Mao <junjie.mao@hotmail.com>
>>
>> offset_of! was stabilized in Rust 1.77.0.  Use an alternative implemenation
>> that was found on the Rust forums, and whose author agreed to license as
>> MIT for use in QEMU.
>>
>> The alternative allows only one level of field access, but apart
>> from this can be used just by replacing core::mem::offset_of! with
>> qemu_api::offset_of!.
>>
>> The actual implementation of offset_of! is done in a declarative macro,
>> but for simplicity and to avoid introducing an extra level of indentation,
>> the trigger is a procedural macro #[derive(offsets)].
>>
>> The procedural macro is perhaps a bit overengineered, but it helps
>> introducing some idioms that will be useful in the future as well.
>>
>> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
>> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Generally looks good to me. Thanks for integrating this!
> 
> It seems Rust does not have builtin support for unit tests expecting
> compilation failures. There is a crate (named trybuild [1]) for that
> purpose but it requires introducing a dozen of new dependencies (see
> below). Do you think it worth the effort? If so, I can take a closer
> look and cook something for initial review (probably post 9.2).
> 
>      trybuild v1.0.101
>      ├── glob v0.3.1
>      ├── serde v1.0.210
>      ├── serde_derive v1.0.210 (proc-macro)
>      │   ├── proc-macro2 v1.0.84 (*)
>      │   ├── quote v1.0.36 (*)
>      │   └── syn v2.0.66 (*)
>      ├── serde_json v1.0.132
>      │   ├── itoa v1.0.11
>      │   ├── memchr v2.7.4
>      │   ├── ryu v1.0.18
>      │   └── serde v1.0.210
>      ├── target-triple v0.1.3
>      ├── termcolor v1.4.1
>      └── toml v0.8.19
>          ├── serde v1.0.210
>          ├── serde_spanned v0.6.8
>          │   └── serde v1.0.210
>          ├── toml_datetime v0.6.8
>          │   └── serde v1.0.210
>          └── toml_edit v0.22.22
>              ├── indexmap v2.6.0
>              │   ├── equivalent v1.0.1
>              │   └── hashbrown v0.15.0
>              ├── serde v1.0.210
>              ├── serde_spanned v0.6.8 (*)
>              ├── toml_datetime v0.6.8 (*)
>              └── winnow v0.6.20
> 
> [1] https://docs.rs/trybuild/latest/trybuild/
> 
> [snip]
>> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
>> index a4bc5d01ee8..c2ea22101e4 100644
>> --- a/rust/qemu-api-macros/src/lib.rs
>> +++ b/rust/qemu-api-macros/src/lib.rs
>> @@ -3,8 +3,34 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>
>>   use proc_macro::TokenStream;
>> -use quote::quote;
>> -use syn::{parse_macro_input, DeriveInput};
>> +use proc_macro2::Span;
>> +use quote::{quote, quote_spanned};
>> +use syn::{
>> +    parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, Data, DeriveInput, Field,
>> +    Fields, Ident, Type, Visibility,
>> +};
>> +
>> +struct CompileError(String, Span);
>> +
>> +impl From<CompileError> for proc_macro2::TokenStream {
>> +    fn from(err: CompileError) -> Self {
>> +        let CompileError(msg, span) = err;
>> +        quote_spanned! { span => compile_error!(#msg); }
> 
> The documentation [2] says "there should be no space before the =>
> token" and that is by intention to tell that `span` is "evaluated in the
> context of proc macro" while those after the arm "in the generated
> code". Should we follow that convention (even though the extra white
> space does not impact building)?

Ah, forgot to reply about this.  Personally I think it's clear enough 
with the "=>", but if there's agreement on removing the space I don't 
oppose it.

Paolo



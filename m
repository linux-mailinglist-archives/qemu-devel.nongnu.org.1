Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C97CA475
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKA2-0006uO-Vh; Mon, 16 Oct 2023 05:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsKA0-0006rz-Br
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK9y-0003Gr-KR
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697449512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FuGprBgpHym4upQP/EdcbB2sWY8K0JyTuG+ASQDZk8Q=;
 b=MTQKumx0sPO2yy1Ct7x0GLnI0l382GdO8BjPrQuyprPu4rl3eN7Fr3M4F7ImSPE9jrwb5W
 OLAEaSrfq4bCmWPv2NV6Uc27VjkjP4T4M/CT2iaUeX/5EuuwAo9sEzTJx6wKA8kdc2D2Ru
 i3W2qRMGSf5cl7er9nBFlWv9ty6owN4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-uEQPEf3QNNKnVyLT9sotAQ-1; Mon, 16 Oct 2023 05:45:01 -0400
X-MC-Unique: uEQPEf3QNNKnVyLT9sotAQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9be8013f2d1so125052166b.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449500; x=1698054300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FuGprBgpHym4upQP/EdcbB2sWY8K0JyTuG+ASQDZk8Q=;
 b=ZCbPnzI5gODSz9JEo5N0ey5IBbxo3mdkTRYTdMPycKDkNkmD2yNqRY4ghwH+4440i6
 TsMyBaprJMSGewJuJgYX8UU2479/a7PU4KhLmBligamcDb0NueRI3tJCTh9X1ki0jHNM
 Usxj2PKEGZ1oT1jxPxhMWqOsub6ATzukGlW5mK8LakDyJP3zw/qwJdP5KNNSMACa0B/Y
 bT14FsO1jfybIep0L2pToc2USDtS9F2XYy5BM8QZ4GtXdkfh1tkkU7LVawdG47uh4c75
 +FltMFCeBXhbwOMmozyh0VFalUC3JcFF1QXVQshtk88hOe+lBLiuZTcGBIIPghia5Kny
 CxLA==
X-Gm-Message-State: AOJu0YzAMmXYOkK/D26IfZ8SUZjgXkrj1c866s+nkDyKUXba/cAiojqU
 cKpirCsk2uYb38NDLRymcwKZRuyvdnx9d5N4cscvWpqEV4ZZBdOuKiYoBuLc27AQDexQI5v9zaa
 iESYg5S/SeI8W175VTzuNaFY=
X-Received: by 2002:a17:907:1b0a:b0:9be:e79e:c75c with SMTP id
 mp10-20020a1709071b0a00b009bee79ec75cmr5034067ejc.21.1697449499794; 
 Mon, 16 Oct 2023 02:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2SO1J1J6T8aFMQOswjNo9AWOM1nkddicbpaU8Vk/J+I9UwjZyz6riv5AoQZq2qgLKiMHdIA==
X-Received: by 2002:a17:907:1b0a:b0:9be:e79e:c75c with SMTP id
 mp10-20020a1709071b0a00b009bee79ec75cmr5034058ejc.21.1697449499478; 
 Mon, 16 Oct 2023 02:44:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 oz13-20020a170906cd0d00b0099bc80d5575sm3609089ejb.200.2023.10.16.02.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:44:58 -0700 (PDT)
Message-ID: <e6eeb599-ecdb-42fd-94ca-8a78e2112e58@redhat.com>
Date: Mon, 16 Oct 2023 11:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] configure: clean up handling of CFI option
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-5-pbonzini@redhat.com>
 <ba834d5f-75ec-1115-b054-16e807d2c89c@linaro.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ba834d5f-75ec-1115-b054-16e807d2c89c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/16/23 11:22, Philippe Mathieu-Daudé wrote:
> On 16/10/23 08:31, Paolo Bonzini wrote:
>> Avoid that --enable-cfi --disable-cfi leaves b_lto set to true.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   configure | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> 
>> @@ -1845,6 +1843,7 @@ if test "$skip_meson" = no; then
>>     # QEMU options
>>     test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
>> +  test "$cfi" != false && meson_option_add "-Db_lto=$cfi"
> 
> Merge as "-Dcfi=$cfi -Db_lto=$cfi"?

Sure, it also needs a little change to meson_option_add though:

diff --git a/configure b/configure
index 3da46ed202d..fd88ef3fec2 100755
--- a/configure
+++ b/configure
@@ -624,7 +624,10 @@ meson_option_build_array() {
  
  meson_options=
  meson_option_add() {
-  meson_options="$meson_options $(quote_sh "$1")"
+  local arg
+  for arg; do
+    meson_options="$meson_options $(quote_sh "$arg")"
+  done
  }
  meson_option_parse() {
    meson_options="$meson_options $(_meson_option_parse "$@")"
@@ -1842,8 +1845,7 @@ if test "$skip_meson" = no; then
    test "$werror" = yes && meson_option_add -Dwerror=true
  
    # QEMU options
-  test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
-  test "$cfi" != false && meson_option_add "-Db_lto=$cfi"
+  test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
    test "$docs" != auto && meson_option_add "-Ddocs=$docs"
    test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
    test "$plugins" = yes && meson_option_add "-Dplugins=true"

Ok to squash that in?

Paolo

> 
>>     test "$docs" != auto && meson_option_add "-Ddocs=$docs"
>>     test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add 
>> "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
>>     test "$plugins" = yes && meson_option_add "-Dplugins=true"
> 
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C387AB3C2
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhGP-0005tO-OT; Fri, 22 Sep 2023 10:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjhGN-0005t8-Hh
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjhGL-0005qu-Ph
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695393368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQVbL+2bqC/Rari9b6OXNf+PyCBA5yKZ6eVhvHX62L8=;
 b=jL20j7gJo9e3oS6gtlHQtKafTzfLJiw/toNO4igV76EVVcKqDRY0/jf8lDwlg2mMKUfQqI
 AL00+96o1PdEqPMqBmHSrzpIBIA6onqku4+OcHaQq1uoLpMNr7tMigUzebwnBTBvgAHfBJ
 dbknUfURwEg0W+wgnBM+cehtkpdXtbY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-i1E2dh7eP8aup1lqyNFu-A-1; Fri, 22 Sep 2023 10:36:06 -0400
X-MC-Unique: i1E2dh7eP8aup1lqyNFu-A-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d814634fe4bso2837836276.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 07:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695393365; x=1695998165;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hQVbL+2bqC/Rari9b6OXNf+PyCBA5yKZ6eVhvHX62L8=;
 b=KxUhvddFbZvKb5AQguFN2tdhMt7cSRkYydp2rX7hVMI7qE1fCMwMuoNH5fmoqf4agt
 adaK6WX6idLNJglpRnpPcexoi7w45uXNOptXxC4xmRtqIk4uvW9m40y2N/jATItO0I+n
 +wurG78dr4bDlGD8uKyLh4wo/1zgi6kZ3KNaOmF773hIYuH4eMVJvL9q2nk6r4kdrbfE
 5jG/xZJHMHzDyKsjLDxtIx4H77n6SU1C86/A0opdlBif1bHqGAIqfwOM4onIE6idKvLN
 bYJS9jn0o2QjrRjHU8AjuSJPSY1r8Uvb409Ttfjd3Z29LME5cQXMInpVRj2csxKJHCL5
 D95g==
X-Gm-Message-State: AOJu0YwB8yF9HKtSsldzrF/qi49HpwQxBkGcKafAof3nxkj3F6ReCE58
 Ps2Uohz96+sis48VVibHwRiHMfmBC9e5tnKe9V6eXwu2ADoijJf0aSVkqg0YJdTR2UIdajyYER5
 WtTSe5j3I3BY5cKs=
X-Received: by 2002:a25:850e:0:b0:d0a:a1fa:b8e4 with SMTP id
 w14-20020a25850e000000b00d0aa1fab8e4mr8995448ybk.38.1695393364865; 
 Fri, 22 Sep 2023 07:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzmFEgqsi0TTtNVXehCzRZ2NhxwTsPjT8H3zplhtYPohCmINS6Dij/CKhtbKJN97r8oBwzSg==
X-Received: by 2002:a25:850e:0:b0:d0a:a1fa:b8e4 with SMTP id
 w14-20020a25850e000000b00d0aa1fab8e4mr8995427ybk.38.1695393364594; 
 Fri, 22 Sep 2023 07:36:04 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-48.web.vodafone.de.
 [109.43.176.48]) by smtp.gmail.com with ESMTPSA id
 t11-20020a0cde0b000000b0065359e0a3efsm1479547qvk.36.2023.09.22.07.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 07:36:04 -0700 (PDT)
Message-ID: <7949b0a2-c05e-2b8e-b10f-b1e5ac910501@redhat.com>
Date: Fri, 22 Sep 2023 16:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] configure: support passthrough of -Dxxx args to meson
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20230922135555.241809-1-berrange@redhat.com>
 <20230922135555.241809-2-berrange@redhat.com>
 <CAFEAcA8gPOx6hH9gZxHOvcTwpSuLO5mCc0zqpTEBSidf0_QaaA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAFEAcA8gPOx6hH9gZxHOvcTwpSuLO5mCc0zqpTEBSidf0_QaaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 22/09/2023 16.00, Peter Maydell wrote:
> On Fri, 22 Sept 2023 at 14:56, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> This can be useful for setting some meson global options, such as the
>> optimization level or debug state, which don't have an analogous
>> option explicitly defined in QEMU's configure wrapper script.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> The commit message says it's adding support for a new feature...
> 
>> ---
>>   configure | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/configure b/configure
>> index e08127045d..cbd7e03e9f 100755
>> --- a/configure
>> +++ b/configure
>> @@ -931,6 +931,8 @@ cat << EOF
>>     bsd-user        all BSD usermode emulation targets
>>     pie             Position Independent Executables
>>
>> +  -Dmesonoptname=val      passthrough option to meson unmodified
>> +
>>   NOTE: The object files are built at the place where configure is launched
>>   EOF
>>   exit 0
> 
> ...but the patch is only updating the --help text. Is there
> a missing piece of code here ?

The patch has already been merged, see commit ff136d2a99253483f ... and IIRC 
I slightly modified it when picking it up (according to the patch 
description), so this here is likely a left-over of a rebase. Daniel, I 
think you can drop this patch here.

  Thomas




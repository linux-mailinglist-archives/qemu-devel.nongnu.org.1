Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF0B7160ED
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:01:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yyK-0007q6-2q; Tue, 30 May 2023 09:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3yyA-0007lc-0p
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3yy8-0001Bc-EX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685451654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lnmb/tQ/TLRa65N+AEWkyiFiWwukdsQS3Rgu1RC68z4=;
 b=BcNeWwCDIKV8e8AISiRSAkU6eK8275u8haMH23rn+nO+4G6yA4kfsoe3CTKyYCCQp7AOlj
 GkXNv5bvsvCVWcmGuODqkDkf43/CRdSbRZvpCT1DBrhsnr1syJMO/wwvGBWoJxhCk0daNN
 IynpSBJhiwTPeHnioLndrdE1kTJV2aw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-9tiYY-ZyP_SmcbLzZGJeAw-1; Tue, 30 May 2023 09:00:53 -0400
X-MC-Unique: 9tiYY-ZyP_SmcbLzZGJeAw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so18534745e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685451652; x=1688043652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lnmb/tQ/TLRa65N+AEWkyiFiWwukdsQS3Rgu1RC68z4=;
 b=lBbhrONfzwV/f73H98brbINEEqEbNHqf+GrYFpjlOJPKFGI/BDbWfQTsk6jbRIBk6R
 1GByixXicytZSj7VQsH2EUqOhDlDo2rhViUgAXhdAPfgcQrrIDKsCrzAyMgVMdToLcpH
 2edEHegO0/OloyZ90Uh9Oe7P4knu1QQzBvibdV72zfL59kyzHZdT0qRjDpPku/MKMDDK
 BOHhIbyWjTa2A0Ws/T8vV9SxugyiDFvIDeADzdqXkLWcK2LB6nfLJ8rfkxRNUfEaNFCf
 nvAwHk2s7HKaIk4dpcKdf5PmpWP2nFwKpKMp9WWKSGVskBiEKnNVB4BwkSslUkgc97NZ
 9Pag==
X-Gm-Message-State: AC+VfDzG2nl2rUfjl+qnSPbAtbfcm5B/lVwEWvUmfhQS3UY5HyCcrgwD
 b644KpO4RKINY7wyXk7gmwrCQdlGAtWYDrjO2YMaonTHPX/2d00BnglZISaCKg/BsTUeOiX5Cvo
 uQrSe8rxM9bXUHuc=
X-Received: by 2002:a1c:6a12:0:b0:3f4:2492:a91f with SMTP id
 f18-20020a1c6a12000000b003f42492a91fmr1480397wmc.27.1685451652111; 
 Tue, 30 May 2023 06:00:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6f4zRldqI4IvRlNXThYhrhzC34Jw/rmBmvvP1YQXkzYcNE096oGYteDtfVLxKASbTzAvomqA==
X-Received: by 2002:a1c:6a12:0:b0:3f4:2492:a91f with SMTP id
 f18-20020a1c6a12000000b003f42492a91fmr1480382wmc.27.1685451651853; 
 Tue, 30 May 2023 06:00:51 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-11.web.vodafone.de.
 [109.43.176.11]) by smtp.gmail.com with ESMTPSA id
 a14-20020adfe5ce000000b003078354f774sm3277491wrn.36.2023.05.30.06.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:00:49 -0700 (PDT)
Message-ID: <d1df1606-d4b9-048c-7ec5-e9c5aa656421@redhat.com>
Date: Tue, 30 May 2023 15:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/5] configure: check for SLOF submodule before building
 pc-bios/s390-ccw
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-5-pbonzini@redhat.com>
 <1981c8e3-9109-7562-0d64-1fa091a28e3c@redhat.com>
 <CABgObfaKt36_iOTw-EOkoEDJz_Br=15PRMJm9xd6YBu2k99i3A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CABgObfaKt36_iOTw-EOkoEDJz_Br=15PRMJm9xd6YBu2k99i3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/05/2023 14.53, Paolo Bonzini wrote:
> On Tue, May 30, 2023 at 2:04 PM Thomas Huth <thuth@redhat.com> wrote:
>> On 27/05/2023 11.28, Paolo Bonzini wrote:
>>> SLOF is required for building the s390-ccw firmware on s390x,
>>> since it is using the libnet code from SLOF for network booting.
>>>
>>> If SLOF is absent and submodules are not updated, pc-bios/s390-ccw
>>> cannot be built.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>    configure | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 1d1b8736c0eb..c92a3b30b9a4 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1662,7 +1662,8 @@ fi
>>>
>>>    # Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
>>>    # (which is the lowest architecture level that Clang supports)
>>> -if have_target s390x-softmmu && probe_target_compiler s390x-softmmu; then
>>> +if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
>>> +    ( test "$git_submodules_action" != ignore || test -f roms/SLOF/VERSION ); then
>>>      write_c_skeleton
>>>      do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
>>>      has_z900=$?
>>
>> Not sure if we really need this. Only the networking part of the s390-ccw
>> bios cannot be build without SLOF, but the main binary still builds fine
>> also without it.
> 
> Thinking more about it---considering we have prebuilt s390-ccw
> binaries, why would someone want to rebuild only one of the ROMs and
> risk breaking the other? Should we keep this patch, and also include
> $(SRC_PATH)/netboot.mak unconditionally from
> pc-bios/s390-ccw/Makefile?

Yes, I think it makes sense nowadays. In the beginning, the network 
bootloader was considered experimental and thus optional, but I think it is 
well established nowadays, so it makes sense to always build it together 
with the other part of the s390-ccw bios.

  Thomas



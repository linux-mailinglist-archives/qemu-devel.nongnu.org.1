Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7187763A3
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:24:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTl2w-0004Gf-RZ; Wed, 09 Aug 2023 11:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTl2v-0004GQ-9W
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:24:25 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTl2t-00024G-Kz
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:24:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-317e427488aso3051901f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691594662; x=1692199462;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oXIdvcJG5xSzM+RlrgVXhDde6Y5Q8+vk9Ss7z2AwnY=;
 b=F9mdf6u97tHzNijnkzwMGgCLMBVErcahMvY6QnclwgLibgqw5PM6NzCX1naa5ilMKX
 MAFPgK/7xwqf2YRTifUUjWzs9TAxBmW6Oki7n0tonza3h4qK/55lS4kXg6pgX4aZion2
 xHOS44yTmQ1WcNWsszyYSzQfH3CN+1WCyvdbygFRamQ5c9hL795M4SvqB/o1mNSW9Td5
 rcMide5nWG5wM2wMgWUvWTiaRk4Np3bd80z3m4+3AxzLPYLLVRma17RY6IIWOWSShR5C
 sKsxGLtwrNbd3+E53sIjz8BmVxkgj64PGJik8S+jwyI+U6Gq+6+BUxr0mn6v0PTrom2z
 N8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691594662; x=1692199462;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8oXIdvcJG5xSzM+RlrgVXhDde6Y5Q8+vk9Ss7z2AwnY=;
 b=gtba+GrcMCnESrohM/n7v707oOLfZ7VIF4PHhH1Wrw4TpEG6TqzSlZJRQk64G0mJtE
 6+WzP71Mxf5V7z8d5kdBkDKFDXr0K75Q1cxJtq8dCqL3I9uGXTUQ4Gr35Y5JNtuhl7rO
 0M9WuWhwf1L5PUR5WLRtYZ7F02hq7xNNjUtNqWKjurSBeDp7ZyUN6WaWAnYQpsLrfPgY
 XjEL8C/H/LySat9EuRGGCqAr5RGiC98T2ls+FXF1bL6CLx6OGdBDMuZ50k50IMdVbuqY
 5KJiKb6lpnD/C0dY9CgvUqm6fr4lHY5ErLkmwnz6GFmYofnSHRDDmuwWhPzaUxmCccVq
 xluw==
X-Gm-Message-State: AOJu0YwmKnEjLpBihxToNiF4dtw2e9hmwnEufdBYBp2DYq4UWh4CyAtB
 64LA246HOO+n2ANEH036OmSbDw==
X-Google-Smtp-Source: AGHT+IGL7wZe1mei0Y9ftr580BrbwFqgq4ORMFytxUEGL81cXsGpowb+6yMMnrMBac8LGmJOhvlzDg==
X-Received: by 2002:adf:e8c7:0:b0:313:f5e9:13ec with SMTP id
 k7-20020adfe8c7000000b00313f5e913ecmr2036064wrn.68.1691594661940; 
 Wed, 09 Aug 2023 08:24:21 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a5d500b000000b003143c9beeaesm16997745wrt.44.2023.08.09.08.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 08:24:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 540241FFBB;
 Wed,  9 Aug 2023 16:24:21 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-2-fufuyqqqqqq@gmail.com>
 <871qgc5l00.fsf@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Yeqi Fu <fufuyqqqqqq@gmail.com>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [RFC v4 01/11] build: Implement logic for sharing
 cross-building config files
Date: Wed, 09 Aug 2023 16:23:20 +0100
In-reply-to: <871qgc5l00.fsf@linaro.org>
Message-ID: <87sf8s44t6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Yeqi Fu <fufuyqqqqqq@gmail.com> writes:
>
>> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
>> ---
>>  configure | 57 +++++++++++++++++++++++++++++++++----------------------
>>  1 file changed, 34 insertions(+), 23 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 2b41c49c0d..a076583141 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1751,56 +1751,67 @@ if test "$ccache_cpp2" =3D "yes"; then
>>    echo "export CCACHE_CPP2=3Dy" >> $config_host_mak
>>  fi
>>=20=20
>> -# tests/tcg configuration
>> -(config_host_mak=3Dtests/tcg/config-host.mak
>> -mkdir -p tests/tcg
>> -echo "# Automatically generated by configure - do not modify" > $config=
_host_mak
>> -echo "SRC_PATH=3D$source_path" >> $config_host_mak
>> -echo "HOST_CC=3D$host_cc" >> $config_host_mak
>> +# Prepare the config files for cross building.
>> +# This process generates 'cross-build/<target>/config-target.mak' files.
>> +# These files are then symlinked to the directories that need them which
>> +# including the TCG tests (tests/tcg/<target>) and the libnative library
>> +# for linux-user (common/native/<target>/).
>> +mkdir -p cross-build
>>=20=20
>> -# versioned checked in the main config_host.mak above
>> -if test -n "$gdb_bin"; then
>> -    echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_host_mak
>> -fi
>> -if test "$plugins" =3D "yes" ; then
>> -    echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
>> -fi
>
> I think there is a merge conflict here because a bunch of the
> config-host.mak output has been squashed. This disabled plugins and gdb
> testing.

Ahh I see now this was intentional because we symlink however it was
lost in the noise of the diff. As Manos pointed out detailing the
movement in the commit message aids reviewers in tracing what has
changed.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


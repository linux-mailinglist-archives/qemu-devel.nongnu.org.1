Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243072C56F
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:05:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hEV-0003Xi-Ib; Mon, 12 Jun 2023 09:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8hEP-0003XD-Ja
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:05:14 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8hEN-0007yW-2v
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:05:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30fbf6603d2so1119392f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686575109; x=1689167109;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9Lmu+nPmGdCfsc4WLPLc6zX6yKATsaO8qTcfKtHw00=;
 b=Z6GGFoZ8sqFB8MJ+ltlb8OStEuFhuLHiQJZSlnSPiL8wZsPTwf9mUbGZfSXdJNUJyC
 NPQbFRACTowbiZvka0pqTUYZ3onx7AGdHYYactocH0/TYz/5Q3cSlvkBtQt2VlNY/J57
 P19XCp9zE4iNjpJX4GlDZ8gT8DyRgEvyp3hhZ0A/voRyH4aA5KLuM0k4zkzXUMXqWkb0
 gNujleu9Y61d0rrenM/1xxVPXSnbwfquuh/Bxh7kC79KvE3sKr/+XB0iAKqvfInRGQ5Z
 GG5CBKiYTPqRgaO5TXxtlWlQQlUgiXStB4WfHNmfI0N38rrcHWj4ZOwiROZOzalzKan1
 q1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686575109; x=1689167109;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k9Lmu+nPmGdCfsc4WLPLc6zX6yKATsaO8qTcfKtHw00=;
 b=BusdcqvDCbul6HAMH3euz3tEE4BV+JdEZfbawHbeAueDN+dmNEL4I6QxH1+Rt5zkNt
 fNGFSRItr/qzmUJ0i5G2imBpSsA4o9g4spRucGslQ40n2JiCvZ5smAwegW6Hhsmez6sU
 J0BxrDEQ27AX1WCuaX/8aho3FTFbkFhcC6N79/GMCiqP8RIol3tdCcLern+oZYmgWPGf
 8MfAnHzZw2wk4/8uLOFez0Ge5gS9u2hC4Qgklei1H3AWEx6tnbWeDJF0WlD63x8WEJj0
 OG2oEvIjlbWmGp6AkkUEiiLDnbo6MrCHYS1NLzMXFj0Q7P4aF/n4GnGsDodY0Uldrsl0
 qAsQ==
X-Gm-Message-State: AC+VfDwUbQxGkH4/5IFNIrIZpXQzG4ImbMWARaeWfH4D4qcVjuieKIq7
 uDzGFk2Fhw29l+TnJIq7KYevyw==
X-Google-Smtp-Source: ACHHUZ5e5vrY6ZVLktKsUQswPYU07T3x9p0LV+ixlKD4Um6eTlZOBLFbXGHxHR6xPSS4kl1JN/IIlg==
X-Received: by 2002:adf:ef8f:0:b0:30e:5bf2:ef1d with SMTP id
 d15-20020adfef8f000000b0030e5bf2ef1dmr5244359wro.43.1686575108873; 
 Mon, 12 Jun 2023 06:05:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a5d5501000000b0030ae69920c9sm12497994wrv.53.2023.06.12.06.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 06:05:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A1981FFBB;
 Mon, 12 Jun 2023 14:05:08 +0100 (BST)
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-2-fufuyqqqqqq@gmail.com>
 <87mt147ue9.fsf@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Yeqi Fu <fufuyqqqqqq@gmail.com>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, =?utf-8?Q?Daniel_P?=
 =?utf-8?Q?=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe  =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC v2 1/6] build: Add configure options for native calls
Date: Mon, 12 Jun 2023 14:02:22 +0100
In-reply-to: <87mt147ue9.fsf@linaro.org>
Message-ID: <87ilbs7rwb.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Yeqi Fu <fufuyqqqqqq@gmail.com> writes:
>
>> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
>> ---
>>  Makefile                            |  4 +++
>>  common-user/native/Makefile.include |  9 ++++++
>>  common-user/native/Makefile.target  | 22 +++++++++++++
>>  configure                           | 50 +++++++++++++++++++++++++++++
>>  docs/devel/build-system.rst         |  4 +++
>>  meson.build                         |  8 +++++
>>  meson_options.txt                   |  2 ++
>>  scripts/meson-buildoptions.sh       |  4 +++
>>  8 files changed, 103 insertions(+)
>>  create mode 100644 common-user/native/Makefile.include
>>  create mode 100644 common-user/native/Makefile.target
>>
>> diff --git a/Makefile b/Makefile
>> index 3c7d67142f..923da109bf 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -185,6 +185,10 @@ SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory =
--quiet)
>>=20=20
>>  include $(SRC_PATH)/tests/Makefile.include
>>=20=20
>> +ifeq ($(CONFIG_USER_NATIVE),y)
>> +	include $(SRC_PATH)/common-user/native/Makefile.include
>> +endif
>> +
>>  all: recurse-all
>>=20=20
>>  ROMS_RULES=3D$(foreach t, all clean distclean, $(addsuffix /$(t), $(ROM=
S)))
>> diff --git a/common-user/native/Makefile.include b/common-user/native/Ma=
kefile.include
>> new file mode 100644
>> index 0000000000..40d20bcd4c
>> --- /dev/null
>> +++ b/common-user/native/Makefile.include
>> @@ -0,0 +1,9 @@
>> +.PHONY: build-native
>> +build-native: $(NATIVE_TARGETS:%=3Dbuild-native-library-%)
>> +$(NATIVE_TARGETS:%=3Dbuild-native-library-%): build-native-library-%:
>> +	$(call quiet-command, \
>> +	    $(MAKE) -C common-user/native/$* $(SUBDIR_MAKEFLAGS), \
>> +	"BUILD","$* native library")
>> +# endif
>> +
>> +all: build-native
>
> I think it would be better if we could add the targets via meson and let
> it deal with the multiple versions. I will defer to Paolo on how to do
> this though.

OK Paolo said we won't expose cross compilers to meson so we are stuck
with pure makefiles for now... however:

<snip>
>> +
>> +(config_host_mak=3Dcommon-user/native/config-host.mak
>> +mkdir -p common-user/native
>> +echo "# Automatically generated by configure - do not modify" > $config=
_host_mak
>> +echo "SRC_PATH=3D$source_path" >> $config_host_mak
>> +echo "HOST_CC=3D$host_cc" >> $config_host_mak
>> +
>> +native_targets=3D
>> +for target in $target_list; do
>> +  arch=3D${target%%-*}
>> +
>> +  case $target in
>> +    *-linux-user|*-bsd-user)
>> +    if probe_target_compiler $target || test -n "$container_image"; then
>> +        mkdir -p "common-user/native/$target"
>> +        config_target_mak=3Dcommon-user/native/$target/config-target.mak
>> +        ln -sf "$source_path/common-user/native/Makefile.target" "commo=
n-user/native/$target/Makefile"
>> +        echo "# Automatically generated by configure - do not modify" >=
 "$config_target_mak"
>> +        echo "TARGET_NAME=3D$arch" >> "$config_target_mak"
>> +        echo "TARGET=3D$target" >> "$config_target_mak"
>> +        eval "target_native_flag=3D\${native_flag_$target_arch}"
>> +        target_cflags=3D"$target_cflags $target_native_flag"
>> +        write_target_makefile "build-native-library-$target" >> "$confi=
g_target_mak"
>> +        native_targets=3D"$native_targets $target"
>> +    fi
>> +  ;;
>> +  esac
>> +done
>
> This is basically replicating what we already have in
> tests/tcg/FOO-linux-user/config-target.mak. I would suggest moving those
> into a common location ($BUILD/targets/foo/compiler.mak) and then fixing
> up TCG tests to use the new location. When you add the native libs you
> can use the same configs.

This should be merged with the existing config_target code.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


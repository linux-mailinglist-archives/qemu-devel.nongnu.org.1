Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DFA75055A
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXaY-0006D1-1y; Wed, 12 Jul 2023 07:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJXaS-0006Ci-H9
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:00:48 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJXaP-0003q0-Kd
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:00:48 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b702319893so109364911fa.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 04:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689159642; x=1691751642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9xBKGOZYKqsydlI1Ngt0A9payrS9zcffaq2RMRVVoLM=;
 b=B2+V2Ok5GM/DSs1GNxaC4ug698p9PkxeCmLjGNeHe4g+5qPaDHezfWa17ogsJGa6JV
 4p6/N5oHqyXP5vHguzs8DYBZQcS5Q0acy5P8kXUeAloGoftdEBch0nNBbJX/lDqndeJU
 Op5AcPFlULT2ZNE4fOAhKZmJStXqS/VWtF85mYy2rOYZpCB2BjHwXBktl2BsPI+beZok
 Z1HCt4GRg1cXoWdUGnjNNs1osx0gAPHVQZKOAagXDGkKOSmOWSEx8DAnBNUJVaEOJRYG
 5ESrjrZzeX46BG0i5WCq55yUszLPtRMAswIY32K8dHxlkRoO9t6rNsjsAx1nlMy94G+y
 nLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689159642; x=1691751642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9xBKGOZYKqsydlI1Ngt0A9payrS9zcffaq2RMRVVoLM=;
 b=H4sMfGLOAioBcG0jrqvO8AGwgJY0v7tZe6trjxNcM/2BCjC8AHp4P1usUCifNLPcGO
 +RNHpIdW1p52OZzjttQkdCgbS5w5HUTFAJYZS4iALLTN0Mbxhv9UOUmVSptfWjUmBNyC
 jQHGTVVulgLxo9WLSRV5jPE8qu4IH5yJytp8EsljIH6TVcwMvXGMYOllFYqc5lYkdTRR
 udobY3ZQkXpTqSWcX9OaAjmjx4uTP0mfLPe313N4iOAcTps6uKj0YhJwHDbAvZmPP4dK
 nJiVG2gbV0OtatjY5iGB2OYOYqZcM17SlOuwl5Avdk3SPl+/2wre8CgteS29z0lLchUu
 cq6Q==
X-Gm-Message-State: ABy/qLYYMsvx7N+jvPbRh/LXxwC27x4CVKVaG/CaxshEmhW230aBmuae
 U1jSLW16wciGjxcVkDrS/mtdVw==
X-Google-Smtp-Source: APBJJlF/MKnheovbV5SqITRWhvCX75XfP3zwbKPwrAB1zGfrmV0GXEGGZcshzLQZRuxKoOuXZtntZA==
X-Received: by 2002:a2e:9206:0:b0:2b5:8eae:7846 with SMTP id
 k6-20020a2e9206000000b002b58eae7846mr15995572ljg.18.1689159641764; 
 Wed, 12 Jul 2023 04:00:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.150.242])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a1709064d8700b00993004239a4sm2369924eju.215.2023.07.12.04.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 04:00:41 -0700 (PDT)
Message-ID: <41ae7db7-8d80-1749-c89d-025ee30bd73d@linaro.org>
Date: Wed, 12 Jul 2023 13:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/4] tests/lcitool: Refresh generated files
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Erik Skultety <eskultet@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Ed Maste <emaste@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-3-philmd@linaro.org> <ZK2YS0v5G3iKyXwJ@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZK2YS0v5G3iKyXwJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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

On 11/7/23 19:58, Daniel P. Berrangé wrote:
> On Tue, Jul 11, 2023 at 04:49:20PM +0200, Philippe Mathieu-Daudé wrote:
>> Refresh the generated files by running:
>>
>>    $ make lcitool-refresh
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/docker/dockerfiles/debian-amd64.docker |  2 -
>>   tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
>>   tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
> 
> I don't know why this would be removing xen/pmem from these files. If
> I run 'lcitool-refresh' on current git master that doesn't happen
> 
> Do you have any other local changes on top ?

No...

$ git checkout origin/master
((887cba855b...))$ git submodule sync
Synchronizing submodule url for 'roms/QemuMacDrivers'
Synchronizing submodule url for 'roms/SLOF'
Synchronizing submodule url for 'roms/edk2'
Synchronizing submodule url for 'roms/ipxe'
Synchronizing submodule url for 'roms/openbios'
Synchronizing submodule url for 'roms/opensbi'
Synchronizing submodule url for 'roms/qboot'
Synchronizing submodule url for 'roms/qemu-palcode'
Synchronizing submodule url for 'roms/seabios'
Synchronizing submodule url for 'roms/seabios-hppa'
Synchronizing submodule url for 'roms/skiboot'
Synchronizing submodule url for 'roms/u-boot'
Synchronizing submodule url for 'roms/u-boot-sam460ex'
Synchronizing submodule url for 'roms/vbootrom'
Synchronizing submodule url for 'tests/lcitool/libvirt-ci'
((887cba855b...))$ git submodule update
((887cba855b...))$ git submodule status
  90c488d5f4a407342247b9ea869df1c2d9c8e266 roms/QemuMacDrivers 
(heads/master)
  6b6c16b4b40763507cf1f518096f3c3883c5cf2d roms/SLOF 
(qemu-slof-20190703-109-g6b6c16b)
  f80f052277c88a67c55e107b550f504eeea947d3 roms/edk2 
(edk2-stable201903-5245-gf80f052277)
  4bd064de239dab2426b31c9789a1f4d78087dc63 roms/ipxe (v1.20.1-70-g4bd064de)
  af97fd7af5e7c18f591a7b987291d3db4ffb28b5 roms/openbios 
(remotes/origin/HEAD)
  2552799a1df30a3dcd2321a8b75d61d06f5fb9fc roms/opensbi (v1.3)
  8ca302e86d685fa05b16e2b208888243da319941 roms/qboot (remotes/origin/HEAD)
  99d9b4dcf27d7fbcbadab71bdc88ef6531baf6bf roms/qemu-palcode (heads/master)
  ea1b7a0733906b8425d948ae94fba63c32b1d425 roms/seabios (rel-1.16.2)
  673d2595d4f773cc266cbf8dbaf2f475a6adb949 roms/seabios-hppa 
(seabios-hppa-v8)
  24a7eb35966d93455520bc2debdd7954314b638b roms/skiboot (v7.0)
  840658b093976390e9537724f802281c9c8439f5 roms/u-boot (v2021.07)
  60b3916f33e617a815973c5a6df77055b2e3a588 roms/u-boot-sam460ex 
(heads/master)
  0c37a43527f0ee2b9584e7fb2fdc805e902635ac roms/vbootrom (heads/master)
  b0f44f929a81c0a604fb7fbf8afc34d37ab0eae9 tests/lcitool/libvirt-ci 
(heads/master-555-gb0f44f92)
((887cba855b...))$ make -C build lcitool-refresh
Generate tests/docker/dockerfiles/alpine.docker
Generate tests/docker/dockerfiles/centos8.docker
Generate tests/docker/dockerfiles/debian-amd64.docker
Generate tests/docker/dockerfiles/fedora.docker
Generate tests/docker/dockerfiles/opensuse-leap.docker
Generate tests/docker/dockerfiles/ubuntu2004.docker
Generate tests/docker/dockerfiles/ubuntu2204.docker
Generate tests/docker/dockerfiles/debian-amd64-cross.docker
Generate tests/docker/dockerfiles/debian-arm64-cross.docker
Generate tests/docker/dockerfiles/debian-armel-cross.docker
Generate tests/docker/dockerfiles/debian-armhf-cross.docker
Generate tests/docker/dockerfiles/debian-mips64el-cross.docker
Generate tests/docker/dockerfiles/debian-mipsel-cross.docker
Generate tests/docker/dockerfiles/debian-ppc64el-cross.docker
Generate tests/docker/dockerfiles/debian-riscv64-cross.docker
Generate tests/docker/dockerfiles/debian-s390x-cross.docker
Generate tests/docker/dockerfiles/fedora-win32-cross.docker
Generate tests/docker/dockerfiles/fedora-win64-cross.docker
Generate .gitlab-ci.d/cirrus/freebsd-13.vars
Generate .gitlab-ci.d/cirrus/macos-12.vars
((887cba855b...))$ git diff -U0
diff --git a/tests/docker/dockerfiles/debian-amd64.docker 
b/tests/docker/dockerfiles/debian-amd64.docker
index e39871c7bb..8f7521fdc2 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -73 +72,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
-                      libpmem-dev \
@@ -99 +97,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
-                      libxen-dev \
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker 
b/tests/docker/dockerfiles/ubuntu2004.docker
index 8f864d19e6..7f60143cbb 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -72 +71,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
-                      libpmem-dev \
@@ -97 +95,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
-                      libxen-dev \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker 
b/tests/docker/dockerfiles/ubuntu2204.docker
index 1d442cdfe6..5162927016 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -73 +72,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
-                      libpmem-dev \
@@ -99 +97,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
-                      libxen-dev \
((887cba855b...))$

🤷


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A923A95DB7
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 08:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76kd-0006ZS-Lb; Tue, 22 Apr 2025 02:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u76ka-0006Yz-0m
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u76kX-0003gL-67
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745301891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=22otT0+cXgGzT18NfqTerVSI5gF7Nxw/3mOCZyHpees=;
 b=iiEuH4CIWxcDYBUmtiGL2PqVXKVtARXemvDYrjabKRYoJaixG4v+kwC31xKCQZsTFsqmBM
 1rThNLAamw/IYdxqHIykUkbVVERoQZfqHrZprhRDbLtqGTExm0Iny+u6Sc8FRXA6P213Ck
 unzwfmmmHcP2F6ipWRl1Q7G/Rb2Ko0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-YBDsDdlmOcC5mpU7-assHQ-1; Tue,
 22 Apr 2025 02:04:46 -0400
X-MC-Unique: YBDsDdlmOcC5mpU7-assHQ-1
X-Mimecast-MFC-AGG-ID: YBDsDdlmOcC5mpU7-assHQ_1745301885
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D81FD180036D; Tue, 22 Apr 2025 06:04:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F39F930001A2; Tue, 22 Apr 2025 06:04:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F78121E6766; Tue, 22 Apr 2025 08:04:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Anton Johansson
 <anjo@rev.ng>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH v3 13/14] qemu/target_info: Add target_aarch64() helper
In-Reply-To: <3242cee6-7485-4958-a198-38d0fc68e8cd@linaro.org> (Pierrick
 Bouvier's message of "Sat, 19 Apr 2025 08:52:02 -0700")
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-14-philmd@linaro.org>
 <41c9061f-ffd8-47a8-b2e8-7c4b2a2c2fcf@linaro.org>
 <ff7cdc09-f11c-43ae-b1e4-668c39db3efe@linaro.org>
 <3242cee6-7485-4958-a198-38d0fc68e8cd@linaro.org>
Date: Tue, 22 Apr 2025 08:04:41 +0200
Message-ID: <87tt6g91fq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

[...]

> At this point, I would like to focus on having a first version of TargetInfo API, and not reviewing any other changes, as things may be modified, and they would need to be reviewed again. It's hard to follow the same abstraction done multiple times in multiple series.
>
> Regarding your proposal for target_system_arch(), I understand that you tried to reuse the existing SysEmuTarget, which was a good intention.
> However, I don't think we should use any string compare for this (which qemu_api_parse does). It has several flaws:

qemu_api_parse()?  Do you mean qapi_enum_parse()?

> - The most important one: it can fail (what if -1 is returned?). Enums can be guaranteed and exhaustive at compile time.
> - It's slower than having the current arch directly known at compile time.
> As well, since SysEmuTarget is a generated enum, it makes it much harder to follow code IMHO.
> QAPI requires those things to be defined from a json file for external usage, but it's not a good reason for being forced to use it in all the codebase as the only possible abstraction.
>
> To have something fast and infallible, we can adopt this solution:
>
> In target_info.h:
>
> /* Named TargetArch to not clash with poisoned TARGET_X */
> typedef enum TargetArch {
>     TARGET_ARCH_AARCH64,
>     TARGET_ARCH_ALPHA,
>     TARGET_ARCH_ARM,
>     TARGET_ARCH_AVR,
>     TARGET_ARCH_HPPA,
>     TARGET_ARCH_I386,
>     TARGET_ARCH_LOONGARCH64,
>     TARGET_ARCH_M68K,
>     TARGET_ARCH_MICROBLAZE,
>     TARGET_ARCH_MICROBLAZEEL,
>     TARGET_ARCH_MIPS,
>     TARGET_ARCH_MIPS64,
>     TARGET_ARCH_MIPS64EL,
>     TARGET_ARCH_MIPSEL,
>     TARGET_ARCH_OR1K,
>     TARGET_ARCH_PPC,
>     TARGET_ARCH_PPC64,
>     TARGET_ARCH_RISCV32,
>     TARGET_ARCH_RISCV64,
>     TARGET_ARCH_RX,
>     TARGET_ARCH_S390X,
>     TARGET_ARCH_SH4,
>     TARGET_ARCH_SH4EB,
>     TARGET_ARCH_SPARC,
>     TARGET_ARCH_SPARC64,
>     TARGET_ARCH_TRICORE,
>     TARGET_ARCH_X86_64,
>     TARGET_ARCH_XTENSA,
>     TARGET_ARCH_XTENSAEB,
> } TargetArch;

Effectively duplicates generated enum SysEmuTarget.  Can you explain why
that's useful?

>
> typedef struct TargetInfo {
> ...
> 	TargetArch target_arch;
> ...
> }
>
> static inline target_arch() {
> 	return target_info()->target_arch;
> }
>
> static inline target_aarch64() {
> 	return target_arch() == TARGET_ARCH_AARCH64;
> }
>
>
> In target_info-stub.c:
>
> #ifdef TARGET_AARCH64
> # define TARGET_ARCH TARGET_ARCH_AARCH64
> #elif TARGET_ARCH_ALPHA
> # define TARGET_ARCH TARGET_ARCH_ALPHA
> ...
> #endif
>
> static const TargetInfo target_info_stub = {
>     ...
>     .target_arch = TARGET_ARCH;
>     ...
> }



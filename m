Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F657B9BEE
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 10:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoK3f-0006PX-GV; Thu, 05 Oct 2023 04:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qoK3d-0006PP-J6
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:50:09 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qoK3b-0008Hv-SO
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:50:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1DED21228;
 Thu,  5 Oct 2023 08:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696495805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/0Vlg1mfGtwG9XnIZ2OX8MtDE3brFVwCEYLef59oPo=;
 b=XxXmYLHIeTglyBPwidbXPNiklaKCyZ0+G7eG7eq0zNuXhrl6X0oPMSYgZVSL1+bhxSK0Tj
 /WhRUg2Jl7zEZgQCP/OTuZly4br+/cCXhoQwjyHY1ImiEnpEMbh819O0208YgPGv/MeO4i
 OcFxxyNxHwqAreJwVYyBFsMmc+BRa3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696495806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/0Vlg1mfGtwG9XnIZ2OX8MtDE3brFVwCEYLef59oPo=;
 b=ZOmqP0uI4pSgIZRLn5zCq6rAl/AYV30c5LYow3sP70rfF66mBvze3tefc0ozmDBKAV52Oi
 Dy6DVAzN+BwMxoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A69BD13438;
 Thu,  5 Oct 2023 08:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Lu90Jr14HmX1aAAAMHmgww
 (envelope-from <cfontana@suse.de>); Thu, 05 Oct 2023 08:50:05 +0000
Message-ID: <00006dc3-f2bc-e539-99cd-137d69a95dfe@suse.de>
Date: Thu, 5 Oct 2023 10:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Wshadow: Better name for 'optarg'?
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 10/4/23 12:05, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
> 
> NAME
>       getopt – get option character from command line argument list
> 
> LIBRARY
>       Standard C Library (libc, -lc)
> 
> SYNOPSIS
>       #include <unistd.h>
> 
>       extern char *optarg;
> 
> 
> qom/object_interfaces.c:262:53: error: declaration shadows a variable in 
> the global scope [-Werror,-Wshadow]
> ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
>                                                      ^
> qom/object_interfaces.c:298:46: error: declaration shadows a variable in 
> the global scope [-Werror,-Wshadow]
> bool user_creatable_add_from_str(const char *optarg, Error **errp)
>                                               ^
> qom/object_interfaces.c:313:49: error: declaration shadows a variable in 
> the global scope [-Werror,-Wshadow]
> void user_creatable_process_cmdline(const char *optarg)
>                                                  ^
> util/guest-random.c:90:45: error: declaration shadows a variable in the 
> global scope [-Werror,-Wshadow]
> int qemu_guest_random_seed_main(const char *optarg, Error **errp)
>                                              ^
> trace/control.c:288:34: error: declaration shadows a variable in the 
> global scope [-Werror,-Wshadow]
> void trace_opt_parse(const char *optarg)
>                                   ^
> /Users/philmd/source/qemu/include/qemu/plugin.h:245:54: error: 
> declaration shadows a variable in the global scope [-Werror,-Wshadow]
> static inline void qemu_plugin_opt_parse(const char *optarg,
>                                                       ^
> os-posix.c:103:31: error: declaration shadows a variable in the global 
> scope [-Werror,-Wshadow]
> bool os_set_runas(const char *optarg)
>                                ^
> os-posix.c:176:32: error: declaration shadows a variable in the global 
> scope [-Werror,-Wshadow]
> void os_set_chroot(const char *optarg)
>                                 ^
> softmmu/tpm.c:178:59: error: declaration shadows a variable in the 
> global scope [-Werror,-Wshadow]
> int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
>                                                            ^
> /Users/philmd/source/qemu/include/qemu/plugin.h:245:54: error: 
> declaration shadows a variable in the global scope [-Werror,-Wshadow]
> static inline void qemu_plugin_opt_parse(const char *optarg,
>                                                       ^
> softmmu/vl.c:1069:44: error: declaration shadows a variable in the 
> global scope [-Werror,-Wshadow]
> static void parse_display_qapi(const char *optarg)
>                                             ^
> softmmu/vl.c:1224:39: error: declaration shadows a variable in the 
> global scope [-Werror,-Wshadow]
> static void monitor_parse(const char *optarg, const char *mode, bool pretty)
>                                        ^
> softmmu/vl.c:1598:17: error: declaration shadows a variable in the 
> global scope [-Werror,-Wshadow]
>      const char *optarg;
>                  ^
> softmmu/vl.c:1634:17: error: declaration shadows a variable in the 
> global scope [-Werror,-Wshadow]
>      const char *optarg = qdict_get_try_str(qdict, "type");
>                  ^
> softmmu/vl.c:1784:45: error: declaration shadows a variable in the 
> global scope [-Werror,-Wshadow]
> static void object_option_parse(const char *optarg)
>                                              ^
> softmmu/vl.c:2710:17: error: declaration shadows a variable in the 
> global scope [-Werror,-Wshadow]
>      const char *optarg;
>                  ^
> net/net.c:1680:35: error: declaration shadows a variable in the global 
> scope [-Werror,-Wshadow]
> bool netdev_is_modern(const char *optarg)
>                                    ^
> net/net.c:1714:38: error: declaration shadows a variable in the global 
> scope [-Werror,-Wshadow]
> void netdev_parse_modern(const char *optarg)
>                                       ^
> net/net.c:1728:60: error: declaration shadows a variable in the global 
> scope [-Werror,-Wshadow]
> void net_client_parse(QemuOptsList *opts_list, const char *optarg)
>                                                             ^
> semihosting/config.c:134:49: error: declaration shadows a variable in 
> the global scope [-Werror,-Wshadow]
> int qemu_semihosting_config_options(const char *optarg)
>                                                  ^
> 
> /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: 
> note: previous declaration is here
> extern char *optarg;                    /* getopt(3) external variables */
>               ^
> 
> Do we want to clean those? Any good name suggestion?

I would suggest "arg".

> 
> Thanks,
> 
> Phil.
> 



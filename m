Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB6B80CFD3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 16:42:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCiPp-00059N-Hs; Mon, 11 Dec 2023 10:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rCiPf-00058h-TG
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:41:44 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rCiPe-0007yO-4r
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:41:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68DEC223F9;
 Mon, 11 Dec 2023 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702309298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hN63TjxIwNbmPRp3u5v1W1be4jlMivJah1BTjFYxi/c=;
 b=pakQ11z2PtVDxgJjGP1Kad5JIzyN6ybFL9EgH96ajsh7zwJQ/hdxOrZ6TPAj+J08sdMNF/
 BZ0TjM7sQ8vNFV37CiGsRndbzYVXkAWERUFEdTFJhqXlfcJURjU9fCeHKROxoy17M4hfAX
 elmILkSyszDadwPPsdqAN/EEDxAe3Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702309298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hN63TjxIwNbmPRp3u5v1W1be4jlMivJah1BTjFYxi/c=;
 b=WaLSlGe/bOAesvNpH7QPnirYyBSaBIAsHuh/PICe9J/GvDgCMpMELNBaOtgNK2QlUFIS+9
 ER911pO4tJqEBBDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702309298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hN63TjxIwNbmPRp3u5v1W1be4jlMivJah1BTjFYxi/c=;
 b=pakQ11z2PtVDxgJjGP1Kad5JIzyN6ybFL9EgH96ajsh7zwJQ/hdxOrZ6TPAj+J08sdMNF/
 BZ0TjM7sQ8vNFV37CiGsRndbzYVXkAWERUFEdTFJhqXlfcJURjU9fCeHKROxoy17M4hfAX
 elmILkSyszDadwPPsdqAN/EEDxAe3Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702309298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hN63TjxIwNbmPRp3u5v1W1be4jlMivJah1BTjFYxi/c=;
 b=WaLSlGe/bOAesvNpH7QPnirYyBSaBIAsHuh/PICe9J/GvDgCMpMELNBaOtgNK2QlUFIS+9
 ER911pO4tJqEBBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E88DA132DA;
 Mon, 11 Dec 2023 15:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ppZxK7Etd2WfPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Dec 2023 15:41:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 05/20] meson: Introduce new instruction set enqcmd to
 the build system.
In-Reply-To: <20231114054032.1192027-6-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-6-hao.xiang@bytedance.com>
Date: Mon, 11 Dec 2023 12:41:35 -0300
Message-ID: <8734w8n3v4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.15
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -3.96
X-Spamd-Result: default: False [-3.96 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.85)[99.36%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.01)[-0.053]; RCPT_COUNT_SEVEN(0.00)[8];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> Enable instruction set enqcmd in build.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  meson.build                   | 2 ++
>  meson_options.txt             | 2 ++
>  scripts/meson-buildoptions.sh | 3 +++
>  3 files changed, 7 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index ec01f8b138..1292ab78a3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2708,6 +2708,8 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
>      int main(int argc, char *argv[]) { return bar(argv[0]); }
>    '''), error_message: 'AVX512BW not available').allowed())
>  
> +config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd'))

We need some sort of detection at configure time whether the feature is
available. There are different compilers and compiler versions,
different Intel CPU versions, different CPU vendors, different
architectures, etc. Not all combinations will support DSA. Check avx512
above.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB28011FD
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:46:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r97ZC-0000NE-Dj; Fri, 01 Dec 2023 12:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r97ZA-0000Mu-6H
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:44:40 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r97Z8-0001bu-Ei
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:44:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 384321FD47;
 Fri,  1 Dec 2023 17:44:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B49881369E;
 Fri,  1 Dec 2023 17:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uU62HoIbamXjcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 01 Dec 2023 17:44:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v2 3/4] configure: add qpl option
In-Reply-To: <20231109154638.488213-4-yuan1.liu@intel.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
 <20231109154638.488213-4-yuan1.liu@intel.com>
Date: Fri, 01 Dec 2023 14:44:32 -0300
Message-ID: <87cyvpbywv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: ++++++++++
X-Spam-Score: 10.29
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 384321FD47
X-Spamd-Result: default: False [10.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(3.00)[1.000];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(4.60)[~all:c];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Yuan Liu <yuan1.liu@intel.com> writes:

> the Query Processing Library (QPL) is an open-source library that
> supports data compression and decompression features.
>
> add --enable-qpl and --disable-qpl options to enable and disable
> the QPL compression accelerator. The QPL compression accelerator
> can accelerate the Zlib compression algorithm during the live migration.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  meson.build                   | 7 +++++++
>  meson_options.txt             | 2 ++
>  scripts/meson-buildoptions.sh | 3 +++
>  3 files changed, 12 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 259dc5f308..b4ba30b4fa 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1032,6 +1032,11 @@ if not get_option('zstd').auto() or have_block
>                      required: get_option('zstd'),
>                      method: 'pkg-config')
>  endif
> +qpl = not_found
> +if not get_option('qpl').auto()
> +    qpl = dependency('libqpl', required: get_option('qpl'),
> +                     method: 'pkg-config')
> +endif

Hm.. I'm not having success with pkg-config:

../meson.build:1043:10: ERROR: Dependency "libqpl" not found, tried
pkgconfig

It seems it doesn't find the static library. I had to use this instead:

qpl = declare_dependency(dependencies: cc.find_library('qpl',
                         required: get_option('qpl')))

What am I missing here?

>  virgl = not_found
>
>  have_vhost_user_gpu = have_tools and targetos == 'linux' and pixman.found()
> @@ -2165,6 +2170,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
>  config_host_data.set('CONFIG_STATX', has_statx)
>  config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
>  config_host_data.set('CONFIG_ZSTD', zstd.found())
> +config_host_data.set('CONFIG_QPL', qpl.found())
>  config_host_data.set('CONFIG_FUSE', fuse.found())
>  config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
>  config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
> @@ -4325,6 +4331,7 @@ summary_info += {'snappy support':    snappy}
>  summary_info += {'bzip2 support':     libbzip2}
>  summary_info += {'lzfse support':     liblzfse}
>  summary_info += {'zstd support':      zstd}
> +summary_info += {'Query Processing Library support': qpl}
>  summary_info += {'NUMA host support': numa}
>  summary_info += {'capstone':          capstone}
>  summary_info += {'libpmem support':   libpmem}
> diff --git a/meson_options.txt b/meson_options.txt
> index 3c7398f3c6..71cd533985 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -255,6 +255,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
>         description: 'xkbcommon support')
>  option('zstd', type : 'feature', value : 'auto',
>         description: 'zstd compression support')
> +option('qpl', type : 'feature', value : 'auto',
> +       description: 'Query Processing Library support')
>  option('fuse', type: 'feature', value: 'auto',
>         description: 'FUSE block device export')
>  option('fuse_lseek', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 7ca4b77eae..0909d1d517 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -220,6 +220,7 @@ meson_options_help() {
>    printf "%s\n" '                  Xen PCI passthrough support'
>    printf "%s\n" '  xkbcommon       xkbcommon support'
>    printf "%s\n" '  zstd            zstd compression support'
> +  printf "%s\n" '  qpl             Query Processing Library support'
>  }
>  _meson_option_parse() {
>    case $1 in
> @@ -556,6 +557,8 @@ _meson_option_parse() {
>      --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
>      --enable-zstd) printf "%s" -Dzstd=enabled ;;
>      --disable-zstd) printf "%s" -Dzstd=disabled ;;
> +    --enable-qpl) printf "%s" -Dqpl=enabled ;;
> +    --disable-qpl) printf "%s" -Dqpl=disabled ;;
>      *) return 1 ;;
>    esac
>  }
> --
> 2.39.3


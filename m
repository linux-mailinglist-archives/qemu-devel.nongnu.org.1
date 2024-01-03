Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F6822EFB
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 14:56:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1iV-0001Of-6O; Wed, 03 Jan 2024 08:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rL1iS-0001MH-Jo; Wed, 03 Jan 2024 08:55:28 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rL1iP-0002MM-PZ; Wed, 03 Jan 2024 08:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704290125; x=1735826125;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=patHji83S3QKwB1IhiSpFYK0Yoli4+3DJ1DD/OyGpPY=;
 b=Q5uOTP2vYfKI0zoxGWCrJiJmtr8KyeLG6WouCqyJRimv+r+PDX9ElAz6
 4GQzv4wazdSit1W6VX8RJJvNcaEqRTKOND8s+7MH8SOYFLC66THXReJdW
 J87E3q2W8WHgROeIR7qQg+8gI8sn/HaEkYRq+qhhuRnluCBnOuRsX1d2U
 RXE0iIHwrbEmkHseucoonXLK+Xa61hGz7TDwnZZ/YlKJqtiBUJxb21NY8
 I6j79KNPmQdXaZbxnXkuSRKxf7r6O73o0vxSklcUPlr/MiKICbjZKKf4+
 bv1+lgAEEdkRQ71AR4NJPckfd2AnqyWilxa4lyscaWlRZddn5jbb0nTAr Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="461319193"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="461319193"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 05:54:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="814269023"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="814269023"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 03 Jan 2024 05:54:28 -0800
Date: Wed, 3 Jan 2024 22:07:21 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v2] scripts/checkpatch: Support codespell checking
Message-ID: <ZZVqGbp59ESAWus2@intel.com>
References: <20231215103448.3822284-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215103448.3822284-1-zhao1.liu@linux.intel.com>
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi maintainers,

Just a kindly ping for review. :-)

Thanks,
Zhao

On Fri, Dec 15, 2023 at 06:34:48PM +0800, Zhao Liu wrote:
> Date: Fri, 15 Dec 2023 18:34:48 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: [PATCH v2] scripts/checkpatch: Support codespell checking
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Add two spelling check options (--codespell and --codespellfile) to
> enhance spelling check through dictionary, which copied the Linux
> kernel's implementation in checkpatch.pl.
> 
> This check uses the dictionary at "/usr/share/codespell/dictionary.txt"
> by default, if there is no dictionary specified under this path, it
> will look for the dictionary of python3's codespell (This requires user
> to add python3's path in environment variable $PATH, and to install
> codespell by "pip install codespell").
> 
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v1:
> * Drop the default dictionary "selling.text" and just support optional
>   spelling check via --codespell and --codespellfile. (Thomas)
> 
> v1: https://lore.kernel.org/qemu-devel/20231204082917.2430223-1-zhao1.liu@linux.intel.com/
> 
> (CC more maintainers who are suggested by get_maintainer.pl in v2.)
> ---
>  scripts/checkpatch.pl | 125 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 105 insertions(+), 20 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 6e4100d2a41c..45a5c66e3eab 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -35,6 +35,9 @@ my $summary_file = 0;
>  my $root;
>  my %debug;
>  my $help = 0;
> +my $codespell = 0;
> +my $codespellfile = "/usr/share/codespell/dictionary.txt";
> +my $user_codespellfile = "";
>  
>  sub help {
>  	my ($exitcode) = @_;
> @@ -66,6 +69,9 @@ Options:
>                               is all off)
>    --test-only=WORD           report only warnings/errors containing WORD
>                               literally
> +  --codespell                Use the codespell dictionary for spelling/typos
> +                             (default:$codespellfile)
> +  --codespellfile            Use this codespell dictionary
>    --color[=WHEN]             Use colors 'always', 'never', or only when output
>                               is a terminal ('auto'). Default is 'auto'.
>    -h, --help, --version      display this help and exit
> @@ -85,28 +91,50 @@ foreach (@ARGV) {
>  }
>  
>  GetOptions(
> -	'q|quiet+'	=> \$quiet,
> -	'tree!'		=> \$tree,
> -	'signoff!'	=> \$chk_signoff,
> -	'patch!'	=> \$chk_patch,
> -	'branch!'	=> \$chk_branch,
> -	'emacs!'	=> \$emacs,
> -	'terse!'	=> \$terse,
> -	'f|file!'	=> \$file,
> -	'strict!'	=> \$no_warnings,
> -	'root=s'	=> \$root,
> -	'summary!'	=> \$summary,
> -	'mailback!'	=> \$mailback,
> -	'summary-file!'	=> \$summary_file,
> -
> -	'debug=s'	=> \%debug,
> -	'test-only=s'	=> \$tst_only,
> -	'color=s'       => \$color,
> -	'no-color'      => sub { $color = 'never'; },
> -	'h|help'	=> \$help,
> -	'version'	=> \$help
> +	'q|quiet+'		=> \$quiet,
> +	'tree!'			=> \$tree,
> +	'signoff!'		=> \$chk_signoff,
> +	'patch!'		=> \$chk_patch,
> +	'branch!'		=> \$chk_branch,
> +	'emacs!'		=> \$emacs,
> +	'terse!'		=> \$terse,
> +	'f|file!'		=> \$file,
> +	'strict!'		=> \$no_warnings,
> +	'root=s'		=> \$root,
> +	'summary!'		=> \$summary,
> +	'mailback!'		=> \$mailback,
> +	'summary-file!'		=> \$summary_file,
> +	'debug=s'		=> \%debug,
> +	'test-only=s'		=> \$tst_only,
> +	'codespell!'		=> \$codespell,
> +	'codespellfile=s'	=> \$user_codespellfile,
> +	'color=s'		=> \$color,
> +	'no-color'		=> sub { $color = 'never'; },
> +	'h|help'		=> \$help,
> +	'version'		=> \$help
>  ) or help(1);
>  
> +if ($user_codespellfile) {
> +	# Use the user provided codespell file unconditionally
> +	$codespellfile = $user_codespellfile;
> +} elsif (!(-f $codespellfile)) {
> +	# If /usr/share/codespell/dictionary.txt is not present, try to find it
> +	# under codespell's install directory: <codespell_root>/data/dictionary.txt
> +	if (($codespell || $help) && which("python3") ne "") {
> +		my $python_codespell_dict = << "EOF";
> +
> +import os.path as op
> +import codespell_lib
> +codespell_dir = op.dirname(codespell_lib.__file__)
> +codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
> +print(codespell_file, end='')
> +EOF
> +
> +		my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;
> +		$codespellfile = $codespell_dict if (-f $codespell_dict);
> +	}
> +}
> +
>  help(0) if ($help);
>  
>  my $exit = 0;
> @@ -337,6 +365,36 @@ our @typeList = (
>  	qr{guintptr},
>  );
>  
> +# Load common spelling mistakes and build regular expression list.
> +my $misspellings;
> +my %spelling_fix;
> +
> +if ($codespell) {
> +	if (open(my $spelling, '<', $codespellfile)) {
> +		while (<$spelling>) {
> +			my $line = $_;
> +
> +			$line =~ s/\s*\n?$//g;
> +			$line =~ s/^\s*//g;
> +
> +			next if ($line =~ m/^\s*#/);
> +			next if ($line =~ m/^\s*$/);
> +			next if ($line =~ m/, disabled/i);
> +
> +			$line =~ s/,.*$//;
> +
> +			my ($suspect, $fix) = split(/->/, $line);
> +
> +			$spelling_fix{$suspect} = $fix;
> +		}
> +		close($spelling);
> +	} else {
> +		warn "No codespell typos will be found - file '$codespellfile': $!\n";
> +	}
> +}
> +
> +$misspellings = join("|", sort keys %spelling_fix) if keys %spelling_fix;
> +
>  # This can be modified by sub possible.  Since it can be empty, be careful
>  # about regexes that always match, because they can cause infinite loops.
>  our @modifierList = (
> @@ -477,6 +535,18 @@ sub top_of_kernel_tree {
>  	return 1;
>  }
>  
> +sub which {
> +	my ($bin) = @_;
> +
> +	foreach my $path (split(/:/, $ENV{PATH})) {
> +		if (-e "$path/$bin") {
> +			return "$path/$bin";
> +		}
> +	}
> +
> +	return "";
> +}
> +
>  sub expand_tabs {
>  	my ($str) = @_;
>  
> @@ -1585,6 +1655,21 @@ sub process {
>  			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
>  		}
>  
> +# Check for various typo / spelling mistakes
> +		if (defined($misspellings) &&
> +		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> +			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
> +				my $typo = $1;
> +				my $blank = copy_spacing($rawline);
> +				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);
> +				my $hereptr = "$hereline$ptr\n";
> +				my $typo_fix = $spelling_fix{lc($typo)};
> +				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
> +				$typo_fix = uc($typo_fix) if ($typo =~ /^[A-Z]+$/);
> +				WARN("'$typo' may be misspelled - perhaps '$typo_fix'?\n" . $hereptr);
> +			}
> +		}
> +
>  # ignore non-hunk lines and lines being removed
>  		next if (!$hunk_line || $line =~ /^-/);
>  
> -- 
> 2.34.1
> 
> 


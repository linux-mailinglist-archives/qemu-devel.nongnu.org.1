Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF32802CF9
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:18:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA49M-0003w1-KN; Mon, 04 Dec 2023 03:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rA49D-0003vV-U5; Mon, 04 Dec 2023 03:17:49 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rA49A-0008Ln-Jx; Mon, 04 Dec 2023 03:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701677865; x=1733213865;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FseLNrhRJQO2dldXL9Brgo7JAYGGDCtpqUTWRwEyuAo=;
 b=VkPyfF8QuNSWA80I3pcfiPCGDWvZGaJqzpYhoOvRcLkOrXRaccrZ46rj
 OnHme3PToMXM1EsoUrUSXXHte+AnANjszub4QlyiZvF8ij94axzuarUjt
 tDaSGHEpRaIG9M8qTkFM6zodN7F3/wCM5O3b3dvtY22T/ElGIlPnddXq7
 5sYDXSRYO+A6d+eyqvE2F9DWDHyB39IuwTMGU/YyMx84RPP9QVvKiaCjX
 e1ur2d6Vmy/roPAX0bpDJgGaygv1uqYvkx5a2lrelQEmP3052anifkx0Q
 cr1zcj1CR5Dx+Gefe2hm3M9lw3mc1VVVTdjlIK8211I0UC041ArRyvbzZ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="581574"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="581574"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 00:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="804829701"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="804829701"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 04 Dec 2023 00:17:13 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 2/3] scripts/checkpatch: Add --codespell and --codespellfile
 options
Date: Mon,  4 Dec 2023 16:29:16 +0800
Message-Id: <20231204082917.2430223-3-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204082917.2430223-1-zhao1.liu@linux.intel.com>
References: <20231204082917.2430223-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Add two spelling check options (--codespell and --codespellfile) to
enhance spelling check through dictionary, which copied the Linux
kernel's implementation in checkpatch.pl.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/checkpatch.pl | 66 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 755a1f683866..20ee07f016ca 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -38,7 +38,10 @@ my $summary_file = 0;
 my $root;
 my %debug;
 my $help = 0;
+my $codespell = 0;
 my $spelling_file = "$D/spelling.txt";
+my $codespellfile = "/usr/share/codespell/dictionary.txt";
+my $user_codespellfile = "";
 
 sub help {
 	my ($exitcode) = @_;
@@ -70,6 +73,9 @@ Options:
                              is all off)
   --test-only=WORD           report only warnings/errors containing WORD
                              literally
+  --codespell                Use the codespell dictionary for spelling/typos
+                             (default:$codespellfile)
+  --codespellfile            Use this codespell dictionary
   --color[=WHEN]             Use colors 'always', 'never', or only when output
                              is a terminal ('auto'). Default is 'auto'.
   -h, --help, --version      display this help and exit
@@ -102,15 +108,37 @@ GetOptions(
 	'summary!'	=> \$summary,
 	'mailback!'	=> \$mailback,
 	'summary-file!'	=> \$summary_file,
-
 	'debug=s'	=> \%debug,
 	'test-only=s'	=> \$tst_only,
+	'codespell!'	=> \$codespell,
+	'codespellfile=s'	=> \$user_codespellfile,
 	'color=s'       => \$color,
 	'no-color'      => sub { $color = 'never'; },
 	'h|help'	=> \$help,
 	'version'	=> \$help
 ) or help(1);
 
+if ($user_codespellfile) {
+	# Use the user provided codespell file unconditionally
+	$codespellfile = $user_codespellfile;
+} elsif (!(-f $codespellfile)) {
+	# If /usr/share/codespell/dictionary.txt is not present, try to find it
+	# under codespell's install directory: <codespell_root>/data/dictionary.txt
+	if (($codespell || $help) && which("python3") ne "") {
+		my $python_codespell_dict = << "EOF";
+
+import os.path as op
+import codespell_lib
+codespell_dir = op.dirname(codespell_lib.__file__)
+codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
+print(codespell_file, end='')
+EOF
+
+		my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;
+		$codespellfile = $codespell_dict if (-f $codespell_dict);
+	}
+}
+
 help(0) if ($help);
 
 my $exit = 0;
@@ -364,6 +392,30 @@ if (open(my $spelling, '<', $spelling_file)) {
 	warn "No typos will be found - file '$spelling_file': $!\n";
 }
 
+if ($codespell) {
+	if (open(my $spelling, '<', $codespellfile)) {
+		while (<$spelling>) {
+			my $line = $_;
+
+			$line =~ s/\s*\n?$//g;
+			$line =~ s/^\s*//g;
+
+			next if ($line =~ m/^\s*#/);
+			next if ($line =~ m/^\s*$/);
+			next if ($line =~ m/, disabled/i);
+
+			$line =~ s/,.*$//;
+
+			my ($suspect, $fix) = split(/->/, $line);
+
+			$spelling_fix{$suspect} = $fix;
+		}
+		close($spelling);
+	} else {
+		warn "No codespell typos will be found - file '$codespellfile': $!\n";
+	}
+}
+
 $misspellings = join("|", sort keys %spelling_fix) if keys %spelling_fix;
 
 # This can be modified by sub possible.  Since it can be empty, be careful
@@ -506,6 +558,18 @@ sub top_of_kernel_tree {
 	return 1;
 }
 
+sub which {
+	my ($bin) = @_;
+
+	foreach my $path (split(/:/, $ENV{PATH})) {
+		if (-e "$path/$bin") {
+			return "$path/$bin";
+		}
+	}
+
+	return "";
+}
+
 sub expand_tabs {
 	my ($str) = @_;
 
-- 
2.34.1



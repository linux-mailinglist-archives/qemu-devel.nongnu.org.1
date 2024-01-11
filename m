Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6582B398
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:03:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQo-0004Br-8u; Thu, 11 Jan 2024 12:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQk-000494-3o
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQh-0003nE-RQ
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qO5heAw+CZ2fcY4dM3EnLtLQdF5yK4B4YLnj2or0YRw=;
 b=J126Uug50F7HC/rpckq9hTkFVJJUpzYXiZWelCyOZYJnWBM0jwTTmNSzBbgtrsAawwx1B3
 cCTsINphKG+yCc6yrKe5SZQKOksjLcJo2+MA5D2gWA3HuaVI0QHBtzWeiaPCxH/NgvmiaR
 zHmyd6/dV/FOFx8SmMTWKZPzYHqTF9M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-hCE7uHh4NJi8PsHRNuLqSQ-1; Thu, 11 Jan 2024 12:01:16 -0500
X-MC-Unique: hCE7uHh4NJi8PsHRNuLqSQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFDC9108BF31;
 Thu, 11 Jan 2024 17:01:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F29E751D5;
 Thu, 11 Jan 2024 17:01:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PULL 14/17] scripts/checkpatch: Support codespell checking
Date: Thu, 11 Jan 2024 18:00:43 +0100
Message-ID: <20240111170047.909117-15-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
References: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Add two spelling check options (--codespell and --codespellfile) to
enhance spelling check through dictionary, which copied the Linux
kernel's implementation in checkpatch.pl.

This check uses the dictionary at "/usr/share/codespell/dictionary.txt"
by default, if there is no dictionary specified under this path, it
will look for the dictionary of python3's codespell (This requires user
to add python3's path in environment variable $PATH, and to install
codespell by "pip install codespell").

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Tested-by: Samuel Tardieu <sam@rfc1149.net>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240105083848.267192-1-zhao1.liu@linux.intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/checkpatch.pl | 125 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 105 insertions(+), 20 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6e4100d2a4..7026895074 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -35,6 +35,9 @@ my $summary_file = 0;
 my $root;
 my %debug;
 my $help = 0;
+my $codespell = 0;
+my $codespellfile = "/usr/share/codespell/dictionary.txt";
+my $user_codespellfile = "";
 
 sub help {
 	my ($exitcode) = @_;
@@ -66,6 +69,9 @@ Options:
                              is all off)
   --test-only=WORD           report only warnings/errors containing WORD
                              literally
+  --codespell                Use the codespell dictionary for spelling/typos
+                             (default: $codespellfile)
+  --codespellfile            Use this codespell dictionary
   --color[=WHEN]             Use colors 'always', 'never', or only when output
                              is a terminal ('auto'). Default is 'auto'.
   -h, --help, --version      display this help and exit
@@ -85,28 +91,50 @@ foreach (@ARGV) {
 }
 
 GetOptions(
-	'q|quiet+'	=> \$quiet,
-	'tree!'		=> \$tree,
-	'signoff!'	=> \$chk_signoff,
-	'patch!'	=> \$chk_patch,
-	'branch!'	=> \$chk_branch,
-	'emacs!'	=> \$emacs,
-	'terse!'	=> \$terse,
-	'f|file!'	=> \$file,
-	'strict!'	=> \$no_warnings,
-	'root=s'	=> \$root,
-	'summary!'	=> \$summary,
-	'mailback!'	=> \$mailback,
-	'summary-file!'	=> \$summary_file,
-
-	'debug=s'	=> \%debug,
-	'test-only=s'	=> \$tst_only,
-	'color=s'       => \$color,
-	'no-color'      => sub { $color = 'never'; },
-	'h|help'	=> \$help,
-	'version'	=> \$help
+	'q|quiet+'		=> \$quiet,
+	'tree!'			=> \$tree,
+	'signoff!'		=> \$chk_signoff,
+	'patch!'		=> \$chk_patch,
+	'branch!'		=> \$chk_branch,
+	'emacs!'		=> \$emacs,
+	'terse!'		=> \$terse,
+	'f|file!'		=> \$file,
+	'strict!'		=> \$no_warnings,
+	'root=s'		=> \$root,
+	'summary!'		=> \$summary,
+	'mailback!'		=> \$mailback,
+	'summary-file!'		=> \$summary_file,
+	'debug=s'		=> \%debug,
+	'test-only=s'		=> \$tst_only,
+	'codespell!'		=> \$codespell,
+	'codespellfile=s'	=> \$user_codespellfile,
+	'color=s'		=> \$color,
+	'no-color'		=> sub { $color = 'never'; },
+	'h|help'		=> \$help,
+	'version'		=> \$help
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
@@ -337,6 +365,36 @@ our @typeList = (
 	qr{guintptr},
 );
 
+# Load common spelling mistakes and build regular expression list.
+my $misspellings;
+my %spelling_fix;
+
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
+$misspellings = join("|", sort keys %spelling_fix) if keys %spelling_fix;
+
 # This can be modified by sub possible.  Since it can be empty, be careful
 # about regexes that always match, because they can cause infinite loops.
 our @modifierList = (
@@ -477,6 +535,18 @@ sub top_of_kernel_tree {
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
 
@@ -1585,6 +1655,21 @@ sub process {
 			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
 		}
 
+# Check for various typo / spelling mistakes
+		if (defined($misspellings) &&
+		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
+			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
+				my $typo = $1;
+				my $blank = copy_spacing($rawline);
+				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);
+				my $hereptr = "$hereline$ptr\n";
+				my $typo_fix = $spelling_fix{lc($typo)};
+				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
+				$typo_fix = uc($typo_fix) if ($typo =~ /^[A-Z]+$/);
+				WARN("'$typo' may be misspelled - perhaps '$typo_fix'?\n" . $hereptr);
+			}
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
2.43.0



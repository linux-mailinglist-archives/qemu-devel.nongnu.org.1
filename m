Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1E8420F5
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jan 2024 11:15:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUl9d-0002uQ-VP; Tue, 30 Jan 2024 05:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUl9Q-0002mQ-CT
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:15:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUl9K-0004xw-OV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706609724;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SnAVLekeBtzgE6u1d1wUfNc18KX8LJl29A5ZpfYgGc=;
 b=V4j8+0rvzjgqeKqWuMmtx5Agd2o+FhW5+5qEGeQEgFyouChVIbMRuCxzwHcL+SLsaa9zIR
 EZUU0EBDek1U0PHYXEmuVo4KtZH1DW2Gu5cg4PTxXItVHKxbY3VCwwMWEgU8FdcI6soNXV
 RluFNwMN++KxNtJTzT70tKlAfHxaS+U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-Vwrl4MQYMxWE_VQpNqO4pA-1; Tue,
 30 Jan 2024 05:15:20 -0500
X-MC-Unique: Vwrl4MQYMxWE_VQpNqO4pA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A11A28116A4;
 Tue, 30 Jan 2024 10:15:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BF7610EA6;
 Tue, 30 Jan 2024 10:15:19 +0000 (UTC)
Date: Tue, 30 Jan 2024 10:15:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in
 cover letter patches
Message-ID: <ZbjMNZpX9kYyw5hW@redhat.com>
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jan 30, 2024 at 12:11:07PM +0200, Manos Pitsidianakis wrote:
> Check if a file argument is a cover letter patch produced by
> git-format-patch --cover-letter; It is initialized with subject suffix "
> *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> exist, warn the user.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Range-diff against v1:
> 1:  64b7ec2287 ! 1:  9bf816eb4c scripts/checkpatch.pl: check for placeholders in cover letter patches
>     @@ scripts/checkpatch.pl: sub process {
>      +# --cover-letter; It is initialized with subject suffix
>      +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
>      +		if ($in_header_lines &&
>     -+		    $rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>     -+        WARN("Patch appears to be a cover letter with uninitialized subject" .
>     -+             " '*** SUBJECT HERE ***'\n$hereline\n");
>     ++				$rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>     ++			WARN("Patch appears to be a cover letter with " .
>     ++						"uninitialized subject '*** SUBJECT HERE ***'\n$hereline\n");
>      +		}
>      +
>      +		if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
>     -+        WARN("Patch appears to be a cover letter with leftover placeholder " .
>     -+             "text '*** BLURB HERE ***'\n$hereline\n");
>     ++			WARN("Patch appears to be a cover letter with " .
>     ++						"leftover placeholder text '*** BLURB HERE ***'\n$hereline\n");
>      +		}
>      +
>       		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
> 
>  scripts/checkpatch.pl | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7026895074..9a8d49f1d8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1650,6 +1650,20 @@ sub process {
>  			$non_utf8_charset = 1;
>  		}
>  
> +# Check if this is a cover letter patch produced by git-format-patch
> +# --cover-letter; It is initialized with subject suffix
> +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
> +		if ($in_header_lines &&
> +				$rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {

This continuation line is now hugely over-indented - it should
be aligned just after the '('

> +			WARN("Patch appears to be a cover letter with " .
> +						"uninitialized subject '*** SUBJECT HERE ***'\n$hereline\n");

As is this

> +		}
> +
> +		if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
> +			WARN("Patch appears to be a cover letter with " .
> +						"leftover placeholder text '*** BLURB HERE ***'\n$hereline\n");

And this.

> +		}
> +
>  		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
>  		    $rawline =~ /$NON_ASCII_UTF8/) {
>  			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
> 
> base-commit: 11be70677c70fdccd452a3233653949b79e97908
> -- 
> γαῖα πυρί μιχθήτω
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



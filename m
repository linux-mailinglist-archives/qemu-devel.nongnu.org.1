Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C769DAB6ABA
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 13:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAgE-00011A-GI; Wed, 14 May 2025 07:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFAeY-0007Vb-OD
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFAeT-0006h4-S8
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=435T9ngpYyO2M8vCISFW/K4Q9bKzMHEKkkAGZIsfQP8=;
 b=SSluikLh72VgDn1LSxVCbDCUgGrmwfU8WNeqpxGWrhvmt9D4FKFIfQuNFpk50JPinjBHO6
 bChZk3xZSLGbugZ29cui8UkTVP4PUCWgsgNqL/GbY+1fcwCIGo4yRDY4eLAHsKAi4fyUMC
 DXSt3oLtDuz0YClk6PmXddALX5H+9iI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-iAOYb19hNTyjzZglVNDzVw-1; Wed, 14 May 2025 07:51:55 -0400
X-MC-Unique: iAOYb19hNTyjzZglVNDzVw-1
X-Mimecast-MFC-AGG-ID: iAOYb19hNTyjzZglVNDzVw_1747223514
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a23c51816dso1556876f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223513; x=1747828313;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=435T9ngpYyO2M8vCISFW/K4Q9bKzMHEKkkAGZIsfQP8=;
 b=DhlNv0pfxVRL1yjHMdajcost8w4rjhqGCHumSjRJ3VveGfPCXXIA4ftj3+Ud4k3b1B
 rM5C0XekI221X871PqpeX0KYbr7MLeZMMY1ggjHrpP7TOBwurvDx6TmvEbHP9pX8XY6l
 g0csJ7cJYFVuiCxHOsZeRw3d12e3bb0AEsLi+cW4f+U+ji4U3qBhEX1+nPiTvJPRxck5
 4zMwbaJHkIjb0KQXWcgwiAFBdvvGU5fNTGMtWRw/1jUfCPlY5xEnV7MSVbip4+AVnDNN
 njVJASP+pd/FNqynGprjKvmP+j3WxERfOsB6vEkt4mZlVQoqnITvJ9OWmxBGRFr9bW3P
 FB1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvzYqkJU4yioT5xF9yX2VqM7KWX0Fu63a9Yild7mk3KLSjcbRm3+98PkmVUpC4lD4p2F5ubd/a/HwX@nongnu.org
X-Gm-Message-State: AOJu0YzONh1Hsle+AXwDwpkg2x2xJ1B3tUpm8KSdqKav4cuTl94iaCiU
 l8kg7oU3dRmLT+rTpeEZILCnPLDKacV7kaXBv5OkEFVRWsBqRpL0fx4914jy1C0ylR0KNRAuIuj
 kiSlfYJcypdh7WC6G+iCYdzFKhT6d9MFuUiKmVd5ymnkJVabdmn0fVT2+kyucPuI=
X-Gm-Gg: ASbGnctWG62gn1ea1XWEzHRwZr5/NrsnGu7NViLhykGTEtMPyAb1MNaFA92oB/KloS8
 JgwDjBqIaU+7IpNEhAAtASjKs0RqDn0bKr8pxiuNlaJyffl8heXeXg3R3vHzI6JynQ3xuGJrEdA
 7ffwBo4FsRAKP1foAfNREIbAGYE9VDRzeVtaTFEyd3vUQmO123ifVnK3tGskK7ade6jIIg2StCw
 GkFgkOrFwyL8NB3Zq04nor4JDEEg1v5/PMhYCwjDZ+mlVP00RrNRQzKpJRnDXUZodvjSuMmtCs+
 iruPP3yw84etjqk2adoTCouerRvst1abmtA2bnT+/O0U+IDgKA==
X-Received: by 2002:a05:6000:22c5:b0:3a2:3c51:7c1c with SMTP id
 ffacd0b85a97d-3a349946af3mr2210020f8f.50.1747223513626; 
 Wed, 14 May 2025 04:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnhhxSX00TnABRyBOnM/hYVnNYPu9pJDhsi6+W8YS6aPiJ/Ja2PF21ng/aBfZ16bnTBeKumw==
X-Received: by 2002:a05:6000:22c5:b0:3a2:3c51:7c1c with SMTP id
 ffacd0b85a97d-3a349946af3mr2210006f8f.50.1747223513246; 
 Wed, 14 May 2025 04:51:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57de0b2sm19781024f8f.19.2025.05.14.04.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 04:51:52 -0700 (PDT)
Message-ID: <c0e68194-6aa4-4ca8-bee3-ebd67cd96489@redhat.com>
Date: Wed, 14 May 2025 13:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] scripts/checkpatch: use new hook for MAINTAINERS
 update check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250512182447.1139105-1-berrange@redhat.com>
 <20250512182447.1139105-7-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250512182447.1139105-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/25 20:24, Daniel P. Berrangé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> When seeing a new/deleted/renamed file we check to see if MAINTAINERS
> is updated, but we don't give the user a list of files affected, as
> we don't want to repeat the same warning many times over.
> 
> Using the new file list hook, we can give a single warning at the
> end with a list of filenames included.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 37 +++++++++++++++++++------------------
>   1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4a18daa384..d416a6dcf9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1442,6 +1442,25 @@ sub process_file_list {
>   		      join("\n  ", @acpi_nontestexpected) .
>   		      "\n\nfound in the same patch\n");
>   	}
> +
> +	my $sawmaintainers = 0;
> +	my @maybemaintainers;
> +	foreach my $fileinfo (@fileinfos) {
> +		if ($fileinfo->{action} ne "modified" &&
> +		    $fileinfo->{filenew} !~ m#^tests/data/acpi/#) {
> +			push @maybemaintainers, $fileinfo->{filenew};
> +		}
> +		if ($fileinfo->{filenew} eq "MAINTAINEfRS") {

MAINTAINEfRS ? looks like a typo.


With that fixed,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> +			$sawmaintainers = 1;
> +		}
> +	}
> +
> +	# If we don't see a MAINTAINERS update, prod the user to check
> +	if (int(@maybemaintainers) > 0 && !$sawmaintainers) {
> +		WARN("added, moved or deleted file(s):\n\n  " .
> +		     join("\n  ", @maybemaintainers) .
> +		     "\n\nDoes MAINTAINERS need updating?\n");
> +	}
>   }
>   
>   # Called at the start of processing a diff hunk for a file
> @@ -1485,7 +1504,6 @@ sub process {
>   
>   	my $in_header_lines = $file ? 0 : 1;
>   	my $in_commit_log = 0;		#Scanning lines before patch
> -	my $reported_maintainer_file = 0;
>   	my $reported_mixing_imported_file = 0;
>   	my $in_imported_file = 0;
>   	my $in_no_imported_file = 0;
> @@ -1760,23 +1778,6 @@ sub process {
>   			}
>   		}
>   
> -# Check if MAINTAINERS is being updated.  If so, there's probably no need to
> -# emit the "does MAINTAINERS need updating?" message on file add/move/delete
> -		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
> -			$reported_maintainer_file = 1;
> -		}
> -
> -# Check for added, moved or deleted files
> -		if (!$reported_maintainer_file && !$in_commit_log &&
> -		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> -		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
> -		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
> -		      (defined($1) || defined($2)))) &&
> -		    $realfile !~ m#^tests/data/acpi/#) {
> -			$reported_maintainer_file = 1;
> -			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> -		}
> -
>   # Check SPDX-License-Identifier references a permitted license
>   		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
>   			&checkspdx($realfile, $1);



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE077151B
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSdGz-00039i-34; Sun, 06 Aug 2023 08:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qSdGt-00039O-Iy; Sun, 06 Aug 2023 08:54:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qSdGr-0004lM-BI; Sun, 06 Aug 2023 08:54:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0237E1F385;
 Sun,  6 Aug 2023 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691326447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYD+CsuZLqnMUjFIYeavYj8daBme12JaHFvRrx0v0V0=;
 b=cYEAHhTBjDqMx5c1t6oBVRtpI24DAvxk09TVTnG1jTu3s9gpPMaMWljSjqqduFbBgKCa63
 RaWMTrWTYlNovKOfzX+d2bkiI427sa+OGiW6joiZkr5hiE8aiH27bCLGpDMzTqv6AYtFkh
 TbpB875rsjfoP3S88zLU/u+fAEZI7gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691326447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYD+CsuZLqnMUjFIYeavYj8daBme12JaHFvRrx0v0V0=;
 b=bsqS887hCg7TYRzbTH6LfqcbfpsT/VnyJoI88SXDGsUwkjMH16ngks9opWpd11/o34iGK9
 PDZ5Gbu5z7o/B/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4198139C4;
 Sun,  6 Aug 2023 12:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b4gyJu6Xz2TXWQAAMHmgww
 (envelope-from <cfontana@suse.de>); Sun, 06 Aug 2023 12:54:06 +0000
Message-ID: <70056113-b72b-7194-0948-3857dfdfb900@suse.de>
Date: Sun, 6 Aug 2023 14:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3] target/s390x: Fix the "ignored match" case in VSTRS
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230804233748.218935-1-iii@linux.ibm.com>
 <20230804233748.218935-3-iii@linux.ibm.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230804233748.218935-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
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

On 8/5/23 01:03, Ilya Leoshkevich wrote:
> Currently the emulation of VSTRS recognizes partial matches in presence
> of \0 in the haystack, which, according to PoP, is not correct:
> 
>     If the ZS flag is one and a zero byte was detected
>     in the second operand, then there can not be a
>     partial match ...
> 
> Add a check for this. While at it, fold a number of explicitly handled
> special cases into the generic logic.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Closes: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00633.html
> Fixes: 1d706f314191 ("target/s390x: vxeh2: vector string search")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

verified that it fixes the problem I encountered,

Tested-by: Claudio Fontana <cfontana@suse.de>

> ---
>  target/s390x/tcg/vec_string_helper.c | 54 +++++++++-------------------
>  1 file changed, 17 insertions(+), 37 deletions(-)
> 
> diff --git a/target/s390x/tcg/vec_string_helper.c b/target/s390x/tcg/vec_string_helper.c
> index 9b85becdfbf..a19f429768f 100644
> --- a/target/s390x/tcg/vec_string_helper.c
> +++ b/target/s390x/tcg/vec_string_helper.c
> @@ -474,9 +474,9 @@ DEF_VSTRC_CC_RT_HELPER(32)
>  static int vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
>                   const S390Vector *v4, uint8_t es, bool zs)
>  {
> -    int substr_elen, substr_0, str_elen, i, j, k, cc;
> +    int substr_elen, i, j, k, cc;
>      int nelem = 16 >> es;
> -    bool eos = false;
> +    int str_leftmost_0;
>  
>      substr_elen = s390_vec_read_element8(v4, 7) >> es;
>  
> @@ -498,47 +498,20 @@ static int vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
>      }
>  
>      /* If ZS, look for eos in the searched string. */
> +    str_leftmost_0 = nelem;
>      if (zs) {
>          for (k = 0; k < nelem; k++) {
>              if (s390_vec_read_element(v2, k, es) == 0) {
> -                eos = true;
> +                str_leftmost_0 = k;
>                  break;
>              }
>          }
> -        str_elen = k;
> -    } else {
> -        str_elen = nelem;
>      }
>  
> -    substr_0 = s390_vec_read_element(v3, 0, es);
> -
> -    for (k = 0; ; k++) {
> -        for (; k < str_elen; k++) {
> -            if (s390_vec_read_element(v2, k, es) == substr_0) {
> -                break;
> -            }
> -        }
> -
> -        /* If we reached the end of the string, no match. */
> -        if (k == str_elen) {
> -            cc = eos; /* no match (with or without zero char) */
> -            goto done;
> -        }
> -
> -        /* If the substring is only one char, match. */
> -        if (substr_elen == 1) {
> -            cc = 2; /* full match */
> -            goto done;
> -        }
> -
> -        /* If the match begins at the last char, we have a partial match. */
> -        if (k == str_elen - 1) {
> -            cc = 3; /* partial match */
> -            goto done;
> -        }
> -
> +    cc = str_leftmost_0 == nelem ? 0 : 1;  /* No match. */
> +    for (k = 0; k < nelem; k++) {
>          i = MIN(nelem, k + substr_elen);
> -        for (j = k + 1; j < i; j++) {
> +        for (j = k; j < i; j++) {
>              uint32_t e2 = s390_vec_read_element(v2, j, es);
>              uint32_t e3 = s390_vec_read_element(v3, j - k, es);
>              if (e2 != e3) {
> @@ -546,9 +519,16 @@ static int vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
>              }
>          }
>          if (j == i) {
> -            /* Matched up until "end". */
> -            cc = i - k == substr_elen ? 2 : 3; /* full or partial match */
> -            goto done;
> +            /* All elements matched. */
> +            if (k > str_leftmost_0) {
> +                cc = 1;  /* Ignored match. */
> +                k = nelem;
> +            } else if (i - k == substr_elen) {
> +                cc = 2;  /* Full match. */
> +            } else {
> +                cc = 3;  /* Partial match. */
> +            }
> +            break;
>          }
>      }
>  



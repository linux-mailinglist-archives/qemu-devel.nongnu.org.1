Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA757B855B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:33:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4nT-0002uI-L6; Wed, 04 Oct 2023 12:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4nQ-0002t6-Mg
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4nL-0001pn-NH
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696437138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AcEdXlR9I20btEo5PCSIzjw+Rlrw1w1JJo87dQyO0mI=;
 b=bUSngmluiYp6e+PR8yv4B7ihYqm2bMSZGY+0PHiQFWE+KBJ2MydDajInNi8CXtqZrc4h7M
 SmTgkvKh/SF2/18RYzrKWD5zkuXJCDC8KRAXTsYXnUo0oAVRWsWw2uFkqYguG1dWuu7/B4
 T4+J1xdkAjMtr7ExmYUhFbS5sB/Pp+0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-Jy8bnlRWPdSj2_I5ppNqaQ-1; Wed, 04 Oct 2023 12:32:16 -0400
X-MC-Unique: Jy8bnlRWPdSj2_I5ppNqaQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3249655593dso29391f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437136; x=1697041936;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcEdXlR9I20btEo5PCSIzjw+Rlrw1w1JJo87dQyO0mI=;
 b=G3DsrMJ/HFAw8XHJSZ5hr3G68oiBGfZ8sX2Uw5CAERpLvs4Ibe0dKZTWtM/cdC7Cci
 eNR5wcqsLZjm9xSi9RSDocQMh4hoCkh2z04OAq+R9qkk2vF8UruzvTDEHD0fde7DAeYQ
 eLuGjPMoEODIYCgABtOdOUSJyWxLrl4Ua9g2fzaTsmN86Ojnm80/DopJEbcjA56hqk+8
 nFpScL2Uso3Vu0DR8mt+rvyMUPX0L5MHvOGJjKSIQnn+3Bf5t5OWpjcg1eMcF2X61lIX
 Blvj2EjPpk1R7v58AUE0f5lhu8yj98CxI0spvvLuZVKpPxy/h/p311jkqMe+GXIw5zqS
 gS4Q==
X-Gm-Message-State: AOJu0YyfO8o0g5KLoQDGz7aALWf98YaLtGb5oj5ypxID2/SaLuI6XyFn
 6IWE3AqlJzY21H7OPX2lmSBxLm6xHo39TI4bzZTvMW6WklgkUYMWZwb/PtO0nUK9+b7Iqb06nHf
 G/BFuRy6okG6AS5w=
X-Received: by 2002:a5d:4d43:0:b0:31c:6420:fff with SMTP id
 a3-20020a5d4d43000000b0031c64200fffmr2462505wru.62.1696437135819; 
 Wed, 04 Oct 2023 09:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVWQGcd0mIDVcbDAb1KlkWzAxolcZyetmDsQqp+GviG78imPsChdBEu0X8304iPQTLYeRC2Q==
X-Received: by 2002:a5d:4d43:0:b0:31c:6420:fff with SMTP id
 a3-20020a5d4d43000000b0031c64200fffmr2462488wru.62.1696437135392; 
 Wed, 04 Oct 2023 09:32:15 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p5-20020adfcc85000000b0031f300a4c26sm4352163wrj.93.2023.10.04.09.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:32:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 28/52] migration/rdma: Check negative error values the
 same way everywhere
In-Reply-To: <87wmwed824.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 25 Sep 2023 09:29:55 +0200")
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-29-armbru@redhat.com>
 <5b2560b5-63ed-37f0-5367-07ca55d43ab4@fujitsu.com>
 <87wmwed824.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:32:14 +0200
Message-ID: <87jzs2uz5d.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:
>
>> On 18/09/2023 22:41, Markus Armbruster wrote:
>>> When a function returns 0 on success, negative value on error,
>>> checking for non-zero suffices, but checking for negative is clearer.
>>> So do that.
>>> 
>>
>> This patch is no my favor convention.
>
> Certainly a matter of taste, which means maintainers get to decide, not
> me.
>
> Failure checks can be confusing in C.  Is
>
>     if (foo(...))
>
> checking for success or for failure?  Impossible to tell.  If foo()
> returns a pointer, it almost certainly checks for success.  If it
> returns bool, likewise.  But if it returns an integer, it probably
> checks for failure.
>
> Getting a condition backwards is a common coding mistake.  Consider
> patch review of
>
>     if (condition) {
>         obviously the error case
>     }
>
> Patch review is more likely to catch a backward condition when the
> condition's sense is locally obvious.
>
> Conventions can help.  Here's the one I like:
>
> * Check for a function's failure the same way everywhere.
>
> * When a function returns something "truthy" on success, and something
>   "falsy" on failure, use
>
>     if (!fun(...))
>
>   Special cases:
>
>   - bool true on success, false on failure
>
>   - non-null pointer on success, null pointer on failure
>
> * When a function returns non-negative value on success, negative value
>   on failure, use
>
>     if (fun(...) < 0)
>
> * Avoid non-negative integer error values.
>
> * Avoid if (fun(...)), because it's locally ambiguous.
>
>> @Peter, Juan
>>
>> I'd like to hear your opinions.
>
> Yes, please.

I agree with Markus here for three reasons:

1 - He is my C - lawyer of reference O-)

2 - He has done a lot of work cleaning the error handling on this file,
    that was completely ugly.

3 - I fully agree that code is more maintenable this way.  I.e. if any
    function changes to return positive values for non error, we get
    better coverage.

Later, Juan.



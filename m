Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D05027D027F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtYeE-0000Zd-CZ; Thu, 19 Oct 2023 15:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYds-0000Fq-Oc
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:25:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYdq-0005DA-S8
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:25:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4609321A64;
 Thu, 19 Oct 2023 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697743509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YTXpSZHwS7r3nO97GQUBRy92U89E+mDVwbT1s/QAtaY=;
 b=VrGwpu+8/NFDqFFd5Q3vr293bE/vm+fQfCIW6Oe8FDMSidfVf1/D6mZJo8opKofkiw5Quf
 VorM8Nm3BBAFfBj97DXlry5mLNek0mHMEpG1Wp2euEiHYqIb9cUH5zL1b0R+YQAPnG0HRG
 tvX6/HAf7JCpak5wpKa6TrBqpuRgTdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697743509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YTXpSZHwS7r3nO97GQUBRy92U89E+mDVwbT1s/QAtaY=;
 b=Pm9enJ+qcMa9xGNFE7+1bLJKIqSOdOTafBOdL/akNMbSjwEv+7NjJV/2c5d920o3ajjyND
 wJC5JQMVXd+o+1Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB7841357F;
 Thu, 19 Oct 2023 19:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id X9t4JZSCMWU8FAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 19:25:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v13 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
In-Reply-To: <0967bdb1-6754-4b86-b552-acec84bd31bd@nutanix.com>
References: <20231012151052.154106-1-het.gala@nutanix.com>
 <9c263a67-4971-418a-a3f7-95998491fb8f@nutanix.com>
 <87h6modmy0.fsf@suse.de>
 <0967bdb1-6754-4b86-b552-acec84bd31bd@nutanix.com>
Date: Thu, 19 Oct 2023 16:25:06 -0300
Message-ID: <8734y676ul.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -6.08
X-Spamd-Result: default: False [-6.08 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.98)[94.93%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 R_RATELIMIT(0.00)[to_ip_from(RLxkmehncim7kksu5aptuhwrr5)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Het Gala <het.gala@nutanix.com> writes:

> On 18/10/23 7:58 pm, Fabiano Rosas wrote:
>> Het Gala <het.gala@nutanix.com> writes:
>>
>>> Fabiano, would your below commits impact this patchset 'make check'
>>> tests ? Because you have added tests for file based migration, which is
>>> still not included in this patchset.
>> AFAICS, the tests shouldn't break.
>>
> I tried two builds to run on Qemu CI/CD pipeline,
>
> Build without those two commits which involved file based migration - 
> https://gitlab.com/galahet/Qemu/-/pipelines/1041554569
>
> Build with those two commits and only 2 patch of the current patchset - 
> https://gitlab.com/galahet/Qemu/-/pipelines/1041215154
>
> I am not 100% certain but because the 'qtest/migration-test' test 
> failed, I was of the view that might be because of those two commits.

I just sent a series on top of this one containing the additions for the
file transport support. Let's move the discussion there.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 127857B83A6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3rZ-00045M-SJ; Wed, 04 Oct 2023 11:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo3rX-00044v-DF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:32:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo3rV-0001Wk-39
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:32:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A75511F86C;
 Wed,  4 Oct 2023 15:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696433551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JCxExep3GmtDfNw6dXwLyzPP3DdDewqSyNYbCFspgzk=;
 b=P7tkWfsCaa7pZpC9ftNbCAyRvc8vcuA3DMlm8F9xcOlObFrEN7+zF571XGrWfu7uw+JTxK
 bp2bkPPuPSn2lUjiNVz2T/AyR0VkOT5VgjADhUWiBpde806zKjsQP6uCIPVYM083M9RanT
 69hpG2HuuN/BRkGgnOKcRuaJFrH8XHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696433551;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JCxExep3GmtDfNw6dXwLyzPP3DdDewqSyNYbCFspgzk=;
 b=oX+uUVuzRCD3kznVFGJst+03oH+akarU2Tl3XFmnI7fqjFW0r5kNss8DSmYxMH7E4X4XeA
 ZsWzTLsigsqtpOCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 370A013A2E;
 Wed,  4 Oct 2023 15:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0aVJAY+FHWUdIAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 15:32:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v11 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
In-Reply-To: <87sf6qpjrz.fsf@suse.de>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <871qea5x7w.fsf@suse.de>
 <ec1a8f2e-ec10-46e2-1a2c-1ae593080ad4@nutanix.com>
 <87sf6qpjrz.fsf@suse.de>
Date: Wed, 04 Oct 2023 12:32:28 -0300
Message-ID: <875y3mpfn7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Fabiano Rosas <farosas@suse.de> writes:

> Het Gala <het.gala@nutanix.com> writes:
>
>> On 04/10/23 7:03 pm, Fabiano Rosas wrote:
>>> Het Gala <het.gala@nutanix.com> writes:
>>>
>>>> This is v11 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
>>>> for upstream review.
>>>>
>>>> Update: Daniel has reviewed all patches and is okay with them. Markus has also
>>>>          given Acked-by tag for patches related to QAPI syntax change.
>>>> Fabiano, Juan and other migration maintainers, let me know if there are still
>>>> improvements to be made in this patchset series.
>>>>
>>>> Link to previous upstream community patchset links:
>>>> v1: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=jsRvKRy1JOiy05KX1CtLqWN1su5XNmKPKuJTSx5sZpU&e=
>>>> v2: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=mzt3n5PD1QclHfpZEh-VMoLkkwT8xqjPYN-1r7MOly0&e=
>>>> v3: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=fa9W71JU6-3xZrjLH7AmElgqwJGUkPeQv3P7n6EXxOM&e=
>>>> v4: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=Xr1y3EvBzEtWT9O1fVNapCb3WnD-aWR8UeXv6J6gZQM&e=
>>>> v5: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=OtK10W2Z0DobrktRfTCMYPxbcMaaZ6f6qoA65D4RG_A&e=
>>>> v6: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=XH-4qFQgdkAKmRsa9DuqaZgJMvGUi1p4-s05AsAEYRo&e=
>>>> v7: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=RwvfliI4wLm7S0TKl5RMku-gSSE-5fZPYH0MkzJdoPw&e=
>>>> v8: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=BZsKBJGVPDWXwGgb2-fAnS9pWzTYuLzI92TmuWBcB3k&e=
>>>> v9: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=YcWFU9I2u-R6QbVjweZ3lFvJlllm-i9o5_jtLBxC_oc&e=
>>>> v10: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=JQt63Ikbz21vmsLmSensQu8zknGuS9bls-IFpndor78&e=
>>>>
>>>> v10 -> v11 changelog:
>>>> -------------------
>>>> - Resolved make check errors as its been almost two months since v10
>>>>    version of this patchset series went out. Till date migration workflow
>>>>    might have changed which caused make check errors.
>>> Sorry, there must be a misunderstanding here. This series still has
>>> problems. Just look at patch 6 that adds the "channel-type" parameter and
>>> patch 10 that uses "channeltype" in the test (without hyphen). This
>>> cannot work.
>> Ack. I will change that.
>>> There's also several instances of g_autoptr being used incorrectly. I
>>> could comment on every patch individually, but this series cannot have
>>> passed make check.
>> Are we allowed to run the make checks ? I am not aware from where these 
>> failures are arising. It would be helpful if you could point out to me 
>> where g_autoptr is incorrectly used ?
>
> I mean just the project's make check command:
>
> cd build/
> ../configure
> make -j$(nproc)
> make -j$(nproc) check
>
>>> Please resend this with the issues fixed and drop the Reviewed-bys from
>>> the affected patches.
>> How to verify which are the affected patches here ?
>
> I'll comment in each patch individually.

Done.

We had some double-frees when using g_autoptr in structures that are
nested into another. The qapi code already descends and frees the
children.

There were also issues with allocating memory and later overwriting the
pointers.

This might still not put us in the most correct situation regarding
memory, but I think it will at least get make check passing. Feel free
to investigate the errors with make check and propose alternative
solutions. It has been a while since I looked at this series, I might
have missed something further.

> We'll also have to add compatibility with the new file: URI that's
> included in the latest migration pull request. I'll add comments on
> where I think we'll need to add code to support that feature.

I'll actually defer here until you post your series with the
fixes. It'll probably be easier if I just send individual additions to
your patches.


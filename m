Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612EC7BFFA8
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqE3V-0006l4-EO; Tue, 10 Oct 2023 10:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqE3T-0006ks-Ao
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:49:51 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqE3Q-0004mS-9r
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:49:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BF892183B;
 Tue, 10 Oct 2023 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696949387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao3EKAViKKEJn/f7Odz5fgOR22pkP46ku6zc8tnm8jE=;
 b=bsySlTWia9jzNtTKxQU50XOTVj7TxD2RHur13tRkyH1H9KftJc72JAklXMganvwLN6y/rk
 WNlgSwKhrXYqeL4fFib2tTOs8Gavj+eVQHCgB7WpYVdNSFM1MIZkWE97+aRc0MvTSvZdM5
 haSdfCDhGvafufwJ1hKYvkqB4HrT/is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696949387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao3EKAViKKEJn/f7Odz5fgOR22pkP46ku6zc8tnm8jE=;
 b=JXh48yDsNBmw3B9siyIZNS5E34vkW/HPW3ElR1qEIL6EwfOkVzNB9OenugnB5Cn/5+PM7j
 PVLyOkpK1ZANCQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95A021348E;
 Tue, 10 Oct 2023 14:49:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2GJZGIpkJWURDgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 10 Oct 2023 14:49:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v12 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
In-Reply-To: <10b5a323-2f94-4488-8c51-07fdfdefc9ac@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
 <87wmvvjymi.fsf@suse.de>
 <5e59637a-d6ba-46e6-9c28-cc8c16c7fa16@nutanix.com>
 <87r0m2siz7.fsf@suse.de> <87lecasgd5.fsf@suse.de>
 <10b5a323-2f94-4488-8c51-07fdfdefc9ac@nutanix.com>
Date: Tue, 10 Oct 2023 11:49:44 -0300
Message-ID: <87il7esfav.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

> On 10/10/2023 7:56 PM, Fabiano Rosas wrote:
>> Fabiano Rosas<farosas@suse.de>  writes:
>>
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>> On 10/10/2023 2:34 AM, Fabiano Rosas wrote:
>>>>> Het Gala<het.gala@nutanix.com>   writes:
>>>>>
>>>>>> This is v12 patchset of modified 'migrate' and 'migrate-incoming' QA=
PI design
>>>>>> for upstream review.
>>>>>>
>>>>>> Would like to thank all the maintainers that actively participated i=
n the v11
>>>>>> patchset discussion and gave insightful suggestions to improve the p=
atches.
>>>>>>
>>>>>> Link to previous upstream community patchset links:
>>>>>> v1:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.=
org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&d=3DDwIFaQ&c=3Ds883Gp=
UCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkOR=
POMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DOXhp-cq93AZ1=
ZRIwKL5wXhx5-8ei7RfBdmmbU9KNDfg&e=3D=20=20=20
>>>>>> v2:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.=
org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&d=3DDwIFaQ&c=3Ds883Gp=
UCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkOR=
POMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3Dr7SYaB2fxLcE=
P2DiHslsbEyaY7ZPrXxageSBRtRZ7TA&e=3D=20=20=20
>>>>>> v3:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.=
org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&d=3DDwIFaQ&c=3Ds883Gp=
UCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkOR=
POMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DfnGhJw56ypUa=
vnslnUL6JeK4OLi7xwh7TGsafaSSZvw&e=3D=20=20=20
>>>>>> v4:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.=
org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&d=3DDwIFaQ&c=3Ds883Gp=
UCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkOR=
POMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DSA4q18GEE4q3=
Eh7sy5nhQ8OZO5KM8kfapiBkSPZYDxE&e=3D=20=20=20
>>>>>> v5:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.=
org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&d=3DDwIFaQ&c=3Ds883Gp=
UCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkOR=
POMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DQRW_aAGHmTBa=
jBnu1a4jcxQFZ1lf1N3RCyLgOt82Ji4&e=3D=20=20=20
>>>>>> v6:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.=
org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&d=3DDwIFaQ&c=3Ds883Gp=
UCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkOR=
POMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D7Dmgm47UdQ0h=
0Y9-XffsUW_ZdeQ-eCCVzhUkigTMKbc&e=3D=20=20=20
>>>>>> v7:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.=
org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&d=3DDwIFaQ&c=3Ds883Gp=
UCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkOR=
POMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D8a3tAfIJ-6st=
1tlYkbjsRWEv-JvEFxokXzanf0WCqzw&e=3D=20=20=20
>>>>>> v8:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.=
org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&d=3DDwIFaQ&c=3Ds883Gp=
UCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkOR=
POMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D4q_F05ZPdhWs=
PJ0fa850gHS90AsVX7MbsaIHi-3OsMI&e=3D=20=20=20
>>>>>> v9:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.=
org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&d=3DDwIFaQ&c=3Ds883Gp=
UCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkOR=
POMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D1wNhJSfSvAoa=
dG06F2JKFHZ2mA4QWSgqvYpt1zRX9qw&e=3D=20=20=20
>>>>>> v10:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu=
.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&d=3DDwIFaQ&c=3Ds883G=
pUCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkO=
RPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DguEm3FuFn7j=
utT4ZB4RlgwttD4IMSBJy1MNh2zp3tYY&e=3D=20=20=20
>>>>>> v11:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu=
.org_archive_html_qemu-2Ddevel_2023-2D10_msg00740.html&d=3DDwIFaQ&c=3Ds883G=
pUCOChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkO=
RPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DW7rbQhebtuW=
tT2ydMuG21OOkbqlh9KxMi1ZM5yZP6Ig&e=3D=20=20=20
>>>>>>
>>>>>> v11 -> v12 changelog:
>>>>>> -------------------
>>>>>> - Resolved double-freeing when using g_autoptr in structures that are
>>>>>>     nested into another.
>>>>>> - Overwriting of pointers to an existing allocated memory is solved =
at
>>>>>>     various places.
>>>>>> - Use of g_autoptr caused make check errors in non-error path while =
going
>>>>>>     out of scope inside function. Added g_steal_pointer() in the non=
-error
>>>>>>     paths wherever required.
>>>>> Please run make check before sending:
>>>>> =E2=96=B6 242/355 qcow2 181  FAIL
>>>>>
>>>>> You can also push your code to your gitlab and run a pipeline with the
>>>>> branch.
>>>> I tested on my setup, and it passed all the checks.
>>> Ok, so this particular test must have been skipped. It's not possible
>>> that the test ran and passed since the issue is a very abrupt abort().
>>>
>> Ok, so I think what is going on is that both your system and CI don't
>> support postcopy_ram so this test is skipped.
>
> Yes, on my setup, postcopy_ram is not supported / enabled for now. So=20
> the test failing is related to post copy, is that a concern for our=20
> patches ?
>
> I looked at the test logs, and the error does not belong to migration=20
> failure imo.
>

The tests (091, 181) are failing due to the hmp_migrate changes from
this series.


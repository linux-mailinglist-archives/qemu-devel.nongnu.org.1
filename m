Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E22CD7BFD87
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:32:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCp0-0006mw-0O; Tue, 10 Oct 2023 09:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqCof-0006jO-7D
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:30:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqCob-0004T3-0Y
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:30:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D9F721F45A;
 Tue, 10 Oct 2023 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696944622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4NphOffYuDwlN99WCduBGFFwPprJOgAJbM+rXoamZc=;
 b=a7yffhRyQJar7p2+Th/h0+gEdu6ANqgxJcoEIGiRJ3nsXZ6+aCW957Dq+f+WwjPIaS49rf
 80SeieW2HD6i1Og3ICNw5LJj19cNd2eLTGbARLV0foUFe7xsfP76nceXgP3w/9vuzaH1hd
 o4F1MqKJhPmc+jfSZJr6iKOE5vfJLfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696944622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4NphOffYuDwlN99WCduBGFFwPprJOgAJbM+rXoamZc=;
 b=LVqE+jV2/6wFZym2lb4g6NxMr8lA4swfEB0yO+vyBq3rrRnOZI0bVNLUmzgO3AfkXabuQK
 tyURDdlv8y7HONBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D5FC1358F;
 Tue, 10 Oct 2023 13:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WPZuDu5RJWXJaQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 10 Oct 2023 13:30:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v12 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
In-Reply-To: <5e59637a-d6ba-46e6-9c28-cc8c16c7fa16@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
 <87wmvvjymi.fsf@suse.de>
 <5e59637a-d6ba-46e6-9c28-cc8c16c7fa16@nutanix.com>
Date: Tue, 10 Oct 2023 10:30:20 -0300
Message-ID: <87r0m2siz7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Het Gala <het.gala@nutanix.com> writes:

> On 10/10/2023 2:34 AM, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> This is v12 patchset of modified 'migrate' and 'migrate-incoming' QAPI =
design
>>> for upstream review.
>>>
>>> Would like to thank all the maintainers that actively participated in t=
he v11
>>> patchset discussion and gave insightful suggestions to improve the patc=
hes.
>>>
>>> Link to previous upstream community patchset links:
>>> v1:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org=
_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&d=3DDwIFaQ&c=3Ds883GpUCO=
ChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPOM=
qBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DOXhp-cq93AZ1ZRI=
wKL5wXhx5-8ei7RfBdmmbU9KNDfg&e=3D=20=20
>>> v2:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org=
_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&d=3DDwIFaQ&c=3Ds883GpUCO=
ChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPOM=
qBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3Dr7SYaB2fxLcEP2D=
iHslsbEyaY7ZPrXxageSBRtRZ7TA&e=3D=20=20
>>> v3:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org=
_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&d=3DDwIFaQ&c=3Ds883GpUCO=
ChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPOM=
qBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DfnGhJw56ypUavns=
lnUL6JeK4OLi7xwh7TGsafaSSZvw&e=3D=20=20
>>> v4:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org=
_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&d=3DDwIFaQ&c=3Ds883GpUCO=
ChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPOM=
qBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DSA4q18GEE4q3Eh7=
sy5nhQ8OZO5KM8kfapiBkSPZYDxE&e=3D=20=20
>>> v5:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org=
_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&d=3DDwIFaQ&c=3Ds883GpUCO=
ChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPOM=
qBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DQRW_aAGHmTBajBn=
u1a4jcxQFZ1lf1N3RCyLgOt82Ji4&e=3D=20=20
>>> v6:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org=
_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&d=3DDwIFaQ&c=3Ds883GpUCO=
ChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPOM=
qBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D7Dmgm47UdQ0h0Y9=
-XffsUW_ZdeQ-eCCVzhUkigTMKbc&e=3D=20=20
>>> v7:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org=
_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&d=3DDwIFaQ&c=3Ds883GpUCO=
ChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPOM=
qBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D8a3tAfIJ-6st1tl=
YkbjsRWEv-JvEFxokXzanf0WCqzw&e=3D=20=20
>>> v8:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org=
_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&d=3DDwIFaQ&c=3Ds883GpUCO=
ChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPOM=
qBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D4q_F05ZPdhWsPJ0=
fa850gHS90AsVX7MbsaIHi-3OsMI&e=3D=20=20
>>> v9:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org=
_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&d=3DDwIFaQ&c=3Ds883GpUCO=
ChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPOM=
qBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D1wNhJSfSvAoadG0=
6F2JKFHZ2mA4QWSgqvYpt1zRX9qw&e=3D=20=20
>>> v10:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DguEm3FuFn7jutT=
4ZB4RlgwttD4IMSBJy1MNh2zp3tYY&e=3D=20=20
>>> v11:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D10_msg00740.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DW7rbQhebtuWtT2=
ydMuG21OOkbqlh9KxMi1ZM5yZP6Ig&e=3D=20=20
>>>
>>> v11 -> v12 changelog:
>>> -------------------
>>> - Resolved double-freeing when using g_autoptr in structures that are
>>>    nested into another.
>>> - Overwriting of pointers to an existing allocated memory is solved at
>>>    various places.
>>> - Use of g_autoptr caused make check errors in non-error path while goi=
ng
>>>    out of scope inside function. Added g_steal_pointer() in the non-err=
or
>>>    paths wherever required.
>> Please run make check before sending:
>> =E2=96=B6 242/355 qcow2 181  FAIL
>>
>> You can also push your code to your gitlab and run a pipeline with the
>> branch.
>
> I tested on my setup, and it passed all the checks.

Ok, so this particular test must have been skipped. It's not possible
that the test ran and passed since the issue is a very abrupt abort().

Try to run 'make check-block' and watch for the test 181. Or run from the
build directory: ./tests/qemu-iotests/check -qcow2 181

I started a gitlab pipeline with this code to rule out anything in my
own setup. Let's see:
https://gitlab.com/farosas/qemu/-/pipelines/1032002487

> [root@06f1b38a5d6a build]# make check
> /rpmbuild/SOURCES/qemu/build/pyvenv/bin/meson test=C2=A0 --no-rebuild -t =
0=C2=A0=20
> --num-processes 1 --print-errorlogs

hmm, hopefuly you're not using an outdated tree that you fetched from
the rpm source package.

...

> I am not sure if something is different in the configuration. I have=20
> never run a pipeline on gitlab though.=C2=A0 Can you point me out to the=
=20
> documentation of gitlab once again

To run a pipeline on Gitlab you need to push a branch to your QEMU fork
and trigger the pipeline via the Build->Pipelines->Run Pipeline
option. Choose the branch from the dropdown and input an environment
variable with key: QEMU_CI and value: 2 in the Variables field.

We have documentation on how to do that directly from the command line
here: https://www.qemu.org/docs/master/devel/ci.html


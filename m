Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4287A5E3C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXBy-0008FY-MH; Tue, 19 Sep 2023 05:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qiXBw-0008F4-C7
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:38:48 -0400
Received: from relay1-d.mail.gandi.net ([2001:4b98:dc4:8::221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qiXBt-0005NS-IP
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:38:48 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CB14240003;
 Tue, 19 Sep 2023 09:38:38 +0000 (UTC)
Message-ID: <93d3a6fa-6bad-8765-c78d-3df4a993d202@ovn.org>
Date: Tue, 19 Sep 2023 11:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <CAJSP0QVf3CFf1zuBnQev-G54SiGZ53MWBj19SyH__19bo=vfWg@mail.gmail.com>
 <1186b0b7-7dc5-d926-e6ff-ba3da2238b9c@ovn.org> <ZPsKUDp7nVS/Z+j2@redhat.com>
 <4508010f-12e8-8565-d091-e8c68ae0493e@ovn.org> <ZPsQcu0HYBaTScnb@redhat.com>
 <755f9eb1-d97f-a359-3050-f3289374655b@ovn.org> <ZPsscpzj9fNtCEOY@redhat.com>
 <c406b8fb-a2f1-8eb2-abc5-af2474edf940@ovn.org> <ZQLAkNPdOA4ncDvF@redhat.com>
 <bfcf7272-c4c9-3b30-28ed-065ee374d681@ovn.org> <ZQlebHldXOFZATSo@redhat.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PULL 00/17] Net patches
In-Reply-To: <ZQlebHldXOFZATSo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: neutral client-ip=2001:4b98:dc4:8::221;
 envelope-from=i.maximets@ovn.org; helo=relay1-d.mail.gandi.net
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_NEUTRAL=0.779 autolearn=ham autolearn_force=no
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

On 9/19/23 10:40, Daniel P. Berrangé wrote:
> On Mon, Sep 18, 2023 at 09:36:10PM +0200, Ilya Maximets wrote:
>> On 9/14/23 10:13, Daniel P. Berrangé wrote:
>>> On Wed, Sep 13, 2023 at 08:46:42PM +0200, Ilya Maximets wrote:
>>>> On 9/8/23 16:15, Daniel P. Berrangé wrote:
>>>>> On Fri, Sep 08, 2023 at 04:06:35PM +0200, Ilya Maximets wrote:
>>>>>> On 9/8/23 14:15, Daniel P. Berrangé wrote:
>>>>>>> On Fri, Sep 08, 2023 at 02:00:47PM +0200, Ilya Maximets wrote:
>>>>>>>> On 9/8/23 13:49, Daniel P. Berrangé wrote:
>>>>>>>>> On Fri, Sep 08, 2023 at 01:34:54PM +0200, Ilya Maximets wrote:
>>>>>>>>>> On 9/8/23 13:19, Stefan Hajnoczi wrote:
>>>>>>>>>>> Hi Ilya and Jason,
>>>>>>>>>>> There is a CI failure related to a missing Debian libxdp-dev package:
>>>>>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/5046139967
>>>>>>>>>>>
>>>>>>>>>>> I think the issue is that the debian-amd64 container image that QEMU
>>>>>>>>>>> uses for testing is based on Debian 11 ("bullseye" aka "oldstable")
>>>>>>>>>>> and libxdp is not available on that release:
>>>>>>>>>>> https://packages.debian.org/search?keywords=libxdp&searchon=names&suite=oldstable&section=all
>>>>>>>>>>
>>>>>>>>>> Hmm.  Sorry about that.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> If we need to support Debian 11 CI then either XDP could be disabled
>>>>>>>>>>> for that distro or libxdp could be compiled from source.
>>>>>>>>>>
>>>>>>>>>> I'd suggest we just remove the attempt to install the package for now,
>>>>>>>>>> building libxdp from sources may be a little painful to maintain.
>>>>>>>>>>
>>>>>>>>>> Can be re-added later once distributions with libxdp 1.4+ will be more
>>>>>>>>>> widely available, i.e. when fedora dockerfile will be updated to 39,
>>>>>>>>>> for example.  That should be soon-ish, right?
>>>>>>>>>
>>>>>>>>> If you follow the process in docs/devel/testing.rst for adding
>>>>>>>>> libxdp in libvirt-ci, then lcitool will "do the right thing"
>>>>>>>>> when we move the auto-generated dockerfiles to new distro versions.
>>>>>>>>
>>>>>>>> Thanks!  I'll prepare changes for libvirt-ci.
>>>>>>>>
>>>>>>>> In the meantime, none of the currently tested images will have a required
>>>>>>>> version of libxdp anyway, so I'm suggesting to just drop this one dockerfile
>>>>>>>> modification from the patch.  What do you think?
>>>>>>>
>>>>>>> Sure, if none of the distros have it, then lcitool won't emit the
>>>>>>> dockerfile changes until we update the inherited distro version.
>>>>>>> So it is sufficient to just update libvirt-ci.git with the mappings.yml
>>>>>>> info for libxdp, and add 'libxdp' to the tests/lcitool/projects/qemu.yml
>>>>>>> file in qemu.git. It will then 'just work' when someone updates the
>>>>>>> distro versions later.
>>>>>>
>>>>>> I posted an MR for libvirt-ci adding libxdp:
>>>>>>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/429
>>>>>>
>>>>>> Please, take a look.
>>>>>>
>>>>>> The docs say that CI will try to build containers with the MR changes,
>>>>>> but I don't think anything except sanity checks is actually tested on MR.
>>>>>> Sorry if I missed something, never used GitLab pipelines before.
>>>>>
>>>>> No, that's our fault - we've broken the CI and your change alerted
>>>>> me to that fact :-)
>>>>>
>>>>>> Note that with this update we will be installing older version of libxdp
>>>>>> in many containers, even though they will not be used by QEMU, unless
>>>>>> they are newer than 1.4.0.
>>>>>
>>>>> No problem, as it means QEMU CI will demonstrate the the meson.build
>>>>> change is ignoring the outdatd libxdp.
>>>>>
>>>>>> tests/lcitool/projects/qemu.yml in qemu.git cannot be updated without
>>>>>> updating a submodule after the MR merge.
>>>>>
>>>>> Yep.
>>>>
>>>> Since all the required changes went into libvirt-ci project, I posted an
>>>> updated patch set named:
>>>>
>>>>   '[PATCH v4 0/2] net: add initial support for AF_XDP network backend'
>>>>
>>>> Please, take a look.
>>>>
>>>> This should fix the CI issues, though I'm not sure how to run QEMU gitlab
>>>> pipelines myself, so I didn't actually test all the images.
>>>
>>>   git push gitlab  -o ci.variable=QEMU_CI=2
>>>
>>> will create pipeline and immediately run all jobs.
>>
>> Thanks!  That worked.  Though I wasn't able to test much anyway as
>> this thing burned through all my free compute credits less than
>> half way through the pipeline. :D
>>
>> So, AFAIU, it's not something an occasional contributor like me can
>> use, unless they are spending their own money.
> 
> That is not the expected behaviour.
> 
> If your repo is a fork of https://gitlab.com/qemu-project/qemu it
> should benefit from a *massive* x125 reduction on CI costs.
> 
> The critical thing is that it *MUST* have been created with the
> 'Fork' button on qemu-project/qemu.

Yeah, it might be that the problem is caused by me accidentally
forking the gitlab.com/qemu/qemu repo instead of qemu-project.

It is fairly confusing that qemu/qemu is not the main repository
of QEMU project.  It seems to be some sort of automated account
and it closely follows updates of the main repository.  It also
has a better name, and it is *not a fork* of the qemu-project.
There practically no indication that qemu/qemu is not a main
repository, except for an icon and a lower star/fork count.
It's easy to fork the wrong one.

Do you folks have control over this account?  Could you maybe add
a description that it is not the official QEMU repository and add
a link to qemu-project?  Right now qemu-project/qemu states that
it is a "QEMU main repository", but qemu/qemu doesn't say anything.


> If that's not the case then
> you will burn CI credits at a cost of 1 minute == 1 credit,
> instead of 1 minute == 0.008 credits. Check this by going to
> the top page of your repo, and looking for a box a little above
> the file list, that says
> 
>     "Forked from QEMU / QEMU"
> 
> If that is not the case, then you'll have to rename your existing
> repo to get it out of the way, and then use the 'Fork' button to
> create a new copy that is tracked as a fork.
> 
> With most accounts getting 400 CI minutes per month, an averge
> QEMU CI run should consume about 7 CI minutes.
> 
> NB, CI credits reset on the 1st of each month

I deleted my fork (there wasn't anything useful there) and re-forked
the correct one.  Will try again next month.  For now "No more CI
minutes available.  You have used 788 out of 400 of your shared Runners
pipeline minutes." :D

Best regards, Ilya Maximets.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB4930F63
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 10:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGmD-0002X2-1W; Mon, 15 Jul 2024 04:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simon.Hamelin@grenoble-inp.org>)
 id 1sTGmA-0002St-1F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:09:38 -0400
Received: from smtpout01-ext2.partage.renater.fr ([194.254.240.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simon.Hamelin@grenoble-inp.org>)
 id 1sTGm7-0004uy-DO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:09:37 -0400
Received: from zmtaauth05.partage.renater.fr (zmtaauth05.partage.renater.fr
 [194.254.240.27])
 by smtpout10.partage.renater.fr (Postfix) with ESMTP id 0D29463DAD;
 Mon, 15 Jul 2024 10:09:22 +0200 (CEST)
Received: from zmtaauth05.partage.renater.fr (localhost [127.0.0.1])
 by zmtaauth05.partage.renater.fr (Postfix) with ESMTPS id E409B201B0;
 Mon, 15 Jul 2024 10:08:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zmtaauth05.partage.renater.fr (Postfix) with ESMTP id DB27D201CD;
 Mon, 15 Jul 2024 10:08:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth05.partage.renater.fr DB27D201CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
 s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1721030933;
 bh=HkyUJ4qL2lJDN6d7DHg8ApEXw9Y6h/6qfi9sJGt1rzs=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=g0yayQadjaYyUW8T9UU14ISaBGzkLenvf43yZ4OvPTUMeAsy4CuZ/hybq+OqJjq+5
 MilXThUBF3Uly16AMAlcs1x7xS+oPPRk/UMU9EshuJAcnSvKXT32egH1dmZuuwqcDN
 FhPggtZ21vSMkSYekutqNpKeFhIaVdhRHNz83tYtUnrpkwCPBVzKLEv7t59RrDjFyk
 xB5qQTBSw3hjv7NMDTVDIGsVXghm8CGDq7q2eZMBLhI3KnmlyyuMZejpXu5hpXWWcI
 xIUQrqI4cjwPOK8Tmxxct+1Qr53jIRgwm8yaNygbA5KVXWWJl+be3HFurZcRLhtTM1
 MZL7ij5stnXkg==
Received: from zmtaauth05.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth05.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id bUngJI3O0x-H; Mon, 15 Jul 2024 10:08:53 +0200 (CEST)
Received: from 188.231.11.184 (unknown [194.254.241.249])
 by zmtaauth05.partage.renater.fr (Postfix) with ESMTPA id 5FD18201B0;
 Mon, 15 Jul 2024 10:08:53 +0200 (CEST)
Message-ID: <ceab7747-1baa-46d3-860d-b99247e3a65c@grenoble-inp.org>
Date: Mon, 15 Jul 2024 10:09:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240710120854.34333-2-simon.hamelin@grenoble-inp.org>
 <87jzhsqm97.fsf@draig.linaro.org>
 <b03c9f17-a99a-4b6e-883b-37ce092d2a57@grenoble-inp.org>
 <95ebaf0d-2dee-4403-94c6-44e654f05b38@linaro.org>
Content-Language: en-US
From: Simon Hamelin <Simon.Hamelin@grenoble-inp.org>
In-Reply-To: <95ebaf0d-2dee-4403-94c6-44e654f05b38@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.8 at clamav04
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefuihhmohhnucfjrghmvghlihhnuceoufhimhhonhdrjfgrmhgvlhhinhesghhrvghnohgslhgvqdhinhhprdhorhhgqeenucggtffrrghtthgvrhhnpeefhfejkedttddvfffgtdeileegieegvedttdeugfeflefhuddtffdttdelgeelueenucfkphepudelgedrvdehgedrvdeguddrvdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleegrddvheegrddvgedurddvgeelpdhhvghlohepudekkedrvdefuddruddurddukeegpdhmrghilhhfrhhomhepufhimhhonhdrjfgrmhgvlhhinhesghhrvghnohgslhgvqdhinhhprdhorhhgpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepphhivghrrhhitghkrdgsohhuvhhivghrsehlihhnrghrohdrohhrghdprhgtphhtthhopegrlhgvgidrsggvnhhnvggvsehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepvghrughnrgigvgestghrrghnshdrohhrghdprhgtphhtthhopehmrgdrmhgrnhguohhurhhrsehgmhgrihhl
 rdgtohhmpdhrtghpthhtoheprhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhg
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=194.254.240.33;
 envelope-from=Simon.Hamelin@grenoble-inp.org;
 helo=smtpout01-ext2.partage.renater.fr
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_HELO_IP_MISMATCH=2.368, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hello Pierrick,

On 7/12/24 19:23, Pierrick Bouvier wrote:
> Hello Simon,
>=20
> On 7/12/24 00:53, Simon Hamelin wrote:
>>
>>
>> On 7/11/24 12:03, Alex Benn=C3=A9e wrote:
>>>> +static void exit_emulation(int return_code)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 exit(return_code);
>>>> +}
>>>> +
>>>> +static void exit_icount_reached(unsigned int cpu_index, void *udata=
)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 qemu_plugin_outs("icount reached, exiting\n");
>>>> +=C2=A0=C2=A0=C2=A0 exit_emulation(icount_exit_code);
>>>> +}
>>>> +
>>>> +static void exit_address_reached(unsigned int cpu_index, void *udat=
a)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
>>>> +=C2=A0=C2=A0=C2=A0 g_mutex_lock(&addrs_ht_lock);
>>>> +=C2=A0=C2=A0=C2=A0 int exit_code =3D GPOINTER_TO_INT(
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_hash_table_lookup(addr=
s_ht, GUINT_TO_POINTER(insn_vaddr)));
>>>> +=C2=A0=C2=A0=C2=A0 g_mutex_unlock(&addrs_ht_lock);
>>>> +=C2=A0=C2=A0=C2=A0 char *msg =3D g_strdup_printf("0x%" PRIx64 " rea=
ched, exiting\n",
>>>> insn_vaddr);
>>>
>>> Dont intermix variable declarations, put them at the top of the block=
.
>>>
>>>> +=C2=A0=C2=A0=C2=A0 qemu_plugin_outs(msg);
>>>> +=C2=A0=C2=A0=C2=A0 exit_emulation(exit_code);
>>>> +}
>>>
>>> How about something like:
>>>
>>> =C2=A0=C2=A0=C2=A0 static void exit_emulation(int return_code, char *=
message)
>>> =C2=A0=C2=A0=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_plugin_outs(message);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(message);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(return_code);
>>> =C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0 static void exit_icount_reached(unsigned int cpu_i=
ndex, void *udata)
>>> =C2=A0=C2=A0=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t insn_vaddr =3D GP=
OINTER_TO_UINT(udata);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *msg =3D g_strdup_pri=
ntf("icount reached at 0x%" PRIx64 ",=20
>>> exiting\n", insn_vaddr);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit_emulation(icount_exit=
_code, msg);
>>> =C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0 static void exit_address_reached(unsigned int cpu_=
index, void=20
>>> *udata)
>>> =C2=A0=C2=A0=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t insn_vaddr =3D GP=
OINTER_TO_UINT(udata);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *msg =3D g_strdup_pri=
ntf("0x%" PRIx64 " reached,=20
>>> exiting\n", insn_vaddr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int exit_code;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_mutex_lock(&addrs_ht_loc=
k);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit_code =3D GPOINTER_TO_=
INT(
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_=
hash_table_lookup(addrs_ht,=20
>>> GUINT_TO_POINTER(insn_vaddr)));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_mutex_unlock(&addrs_ht_l=
ock);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit_emulation(exit_code, =
msg);
>>> =C2=A0=C2=A0=C2=A0 }
>>>
>>>
>>
>> Looks good to me, will definitly put that in the next patch !
>>
>>>> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const qemu_info_t *info,=20
>>>> int argc,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char **argv)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 addrs_ht =3D g_hash_table_new(NULL, g_direct_equ=
al);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 insn_count_sb =3D=20
>>>> qemu_plugin_scoreboard_new(sizeof(InstructionsCount));
>>>> +=C2=A0=C2=A0=C2=A0 insn_count =3D qemu_plugin_scoreboard_u64_in_str=
uct(
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insn_count_sb, Instructi=
onsCount, insn_count);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < argc; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *opt =3D argv[i];
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_auto(GStrv) tokens =3D=
 g_strsplit(opt, "=3D", 2);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_strcmp0(tokens[0],=
 "icount") =3D=3D 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
g_auto(GStrv) icount_tokens =3D g_strsplit(tokens[1],=20
>>>> ":", 2);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
icount =3D g_ascii_strtoull(icount_tokens[0], NULL, 0);
>>>
>>>
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (icount < 1 || g_strrstr(icount_tokens[0], "-") !=3D
>>>> NULL) {
>>>
>>> I don't think strstoull would even parse something with - in it so I
>>> would just do:
>>>
>>> =C2=A0=C2=A0=C2=A0 if (icount =3D=3D 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* fail */
>>> =C2=A0=C2=A0=C2=A0 }
>>>
>>
>> According to the GLib documentation: "Note that input with a leading
>> minus sign (-) is accepted, and will return the negation of the parsed
>> number, unless that would overflow a guint64". So i guess we need to
>> keep this check.
>>
>>>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>>>> index f7d7b9e3a4..954623f9bf 100644
>>>> --- a/docs/devel/tcg-plugins.rst
>>>> +++ b/docs/devel/tcg-plugins.rst
>>>> @@ -642,6 +642,28 @@ The plugin has a number of arguments, all of=20
>>>> them are optional:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 configuration arguments implies ``l2=3Don``=
.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 (default: N =3D 2097152 (2MB), B =3D 64, A =
=3D 16)
>>>> +- contrib/plugins/stoptrigger.c
>>>> +
>>>> +The stoptrigger plugin allows to setup triggers to stop emulation.
>>>> +It can be used for research purposes to launch some code and=20
>>>> precisely stop it
>>>> +and understand where its execution flow went.
>>>> +
>>>> +Two types of triggers can be configured: a count of instructions to=
=20
>>>> stop at,
>>>> +or an address to stop at. Multiple triggers can be set at once.
>>>> +
>>>> +By default, QEMU will exit with return code 0. A custom return code=
=20
>>>> can be
>>>> +configured for each trigger using ``:CODE`` syntax.
>>>> +
>>>> +For example, to stop at the 20-th instruction with return code 41,=20
>>>> at address
>>>> +0xd4 with return code 0 or at address 0xd8 with return code 42::
>>>> +
>>>> +=C2=A0 $ qemu-system-aarch64 $(QEMU_ARGS) \
>>>> +=C2=A0=C2=A0=C2=A0 -plugin=20
>>>> ./contrib/plugins/libstoptrigger.so,icount=3D20:41,addr=3D0xd4,addr=3D=
0xd8:42 -d plugin
>>>> +
>>>> +The plugin will log the reason of exit, for example::
>>>> +
>>>> +=C2=A0 0xd4 reached, exiting
>>>> +
>>>> =C2=A0=C2=A0 Plugin API
>>>> =C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Otherwise it looks good to me. Unless you want to tackle additional e=
xit
>>> modes?
>>>
>>> What is your current use case for this?
>>>
>>
>> I'm currently using this plugin to determine where my programm stop
>> after a given number of instructions executed.
>>
>=20
> Could you share a bit more information on the final goal, if possible?
> Is that used for fuzzing binaries, security analysis, or other things?

I'm currently using this plugin for security analysis purposes.=20
Basically my goal is to simulate fault injection using QEMU. To do so=20
I'm using this plugin along with another plugin that skips an=20
instruction at a given address. With this plugin I'm able to see how the=20
program reacts to the fault and stop it with a custom return code.=20
Basically there are 4 cases:
    - The fault does not disrupt the program and it reaches the expected=20
address.
    - The fault disrupt the program and it reaches an unexpected address=20
known as the "target" address.
    - The fault disrupt the program in such a way that it executes a lot=20
of instructions without reaching the expected address, this situation is=20
known as a "timeout".
    - The fault crashes the guest, causing it to reach an error handler=20
address.

In short, here's a command line that illustrates how I use the plugin:

$ qemu-system-aarch64 $(QEMU_ARGS) -plugin=20
./contrib/plugins/libstoptrigger.so,icount=3Dtimeout_count,addr=3Daddr=3D=
expected_addr:0,error_handler_addr:1,target_addr:2=20
-d plugin

--
Simon Hamelin

